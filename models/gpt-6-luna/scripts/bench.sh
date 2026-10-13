#!/bin/sh
# Ask Beatles Bench's 1,501 knowledge questions of gpt-6-luna through ThinkThen's built-in openai backend, then score them.
#   scripts/bench.sh BENCH_DIR NAME [FLAG...]
# BENCH_DIR is a clone of https://github.com/botassembly/beatles-bench. The answers, the recording and the wall time
# of each call go to BENCH_DIR/results/runs/<today>-thinkthen-NAME; running again the same day resumes a stopped run.
# Each FLAG passes to every thinkthen call, such as --timeout 120 when the backend stalls.
# The scores go to BENCH_DIR/results/tables/ (accuracy.tsv and cost.tsv). Real requests, real spend.
# The key comes from OPENAI_API_KEY; this script never reads it.
set -eu
bench=$1
run=$bench/results/runs/$(date +%F)-thinkthen-$2
shift 2
mkdir -p "$run"
BEATLES_BENCH_MODEL=gpt-6-luna BENCH_THINKTHEN_ARGS="--backend openai $*" \
  "$bench/scripts/run/thinkthen.sh" live "$run"
python3 "$bench/scripts/score/analyze.py" "$run"
