#!/bin/sh
# Ask each of the ten ThinkThen functions one small question and time each call.
#   scripts/functions.sh BACKEND [MODEL] [--plan]
# BACKEND is a ThinkThen built-in backend name, such as typesafe or liquid. MODEL overrides its default model.
# With --plan, each call prints its plan and sends nothing.
# Prints one tab-separated row per function: name, exit code, wall seconds, requests sent, input tokens and output
# tokens, the last three from the run facts line ThinkThen prints under --facts. The answers go to standard error.
# Needs jq.
# The cache is off, so every call reaches the backend. The key comes from the backend's own variable; this script
# never reads it.
set -u
TT=${THINKTHEN_BIN:-thinkthen}
backend=$1; shift
model=""
plan=""
for a; do
  case $a in
    --plan) plan=--plan ;;
    *) model=$a ;;
  esac
done
dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT

printf '%s\n' 'From: a customer' 'Subject: order 4417' '' \
  'The blender arrived with a cracked jug. I do not want a replacement.' \
  'Please put the money back on my card.' > "$dir/message.txt"
printf '%s\n' \
  '{"id":"ISS-101","body":"Export to CSV writes an empty file. Steps: open any report, choose Export, pick CSV, save. The file is 0 bytes every time on build 4.2.1."}' \
  '{"id":"ISS-102","body":"Could we get a dark theme? The white background is rough at night."}' \
  '{"id":"ISS-103","body":"App is slow sometimes. Not sure when. It just feels laggy lately."}' > "$dir/issues.jsonl"
printf '%s\n' \
  'Orders are picked the same working day when they are placed before 15:00.' \
  'Standard delivery arrives in two to four working days.' \
  'Express delivery arrives the next working day and costs extra.' \
  'Returns are accepted within 30 days of delivery.' > "$dir/policy.txt"
cat > "$dir/checks.json" <<'JSON'
{"version": 1, "questions": {
  "refund": {"decide": "Does the writer ask for money back?"},
  "team": {"choose": "Which team owns this request?", "options": ["billing", "shipping", "account", "other"]}
}}
JSON
echo 'Maria Chen joined Northwind Freight in Chicago last spring.' > "$dir/people.txt"
echo '[{"name":"Maria Chen","kind":"person"},{"name":"Northwind Freight","kind":"organization"}]' > "$dir/entities.json"

# run NAME INPUT ARGS...: time one call reading INPUT on standard input.
run() {
  name=$1 input=$2; shift 2
  set -- "$@" --backend "$backend" --no-cache --facts
  [ -n "$model" ] && set -- "$@" --model "$model"
  [ -n "$plan" ] && set -- "$@" --plan
  start=$(date +%s.%N)
  "$TT" "$@" < "$input" > "$dir/out" 2> "$dir/err"
  code=$?
  end=$(date +%s.%N)
  facts=$(grep -E '^\{"schema":"thinkthen.run/1"' "$dir/err" | tail -1 |
    jq -r '[.requests_sent, (.input_tokens // 0), (.output_tokens // 0)] | @tsv')
  printf '%s\t%s\t%.3f\t%s\n' "$name" "$code" "$(echo "$end - $start" | bc)" "$facts"
  { echo "== $name"; cat "$dir/out"; grep -v -E '^\{' "$dir/err"; } >&2
}

printf 'function\texit\twall_s\trequests\tinput_tokens\toutput_tokens\n'
run decide "$dir/message.txt" decide 'Does the customer ask for money back?'
run choose "$dir/message.txt" choose 'Which team owns this request?' billing shipping account other
run tag "$dir/message.txt" tag 'What does the customer report?' damage late_delivery refund_request wrong_item
run score "$dir/message.txt" score 'How upset is the customer?' calm annoyed angry
run filter "$dir/issues.jsonl" filter 'Does the report give steps that would reproduce a defect?' --jsonl --field /body
run rank "$dir/issues.jsonl" rank 'Does the report describe a defect?' --jsonl --field /body
run find "$dir/policy.txt" find 'When does a standard order reach the customer?'
run annotate "$dir/message.txt" annotate "$dir/checks.json"
run recognize "$dir/people.txt" recognize person organization place
run relate "$dir/entities.json" relate 'works_for=person:organization' --context "$dir/people.txt"
