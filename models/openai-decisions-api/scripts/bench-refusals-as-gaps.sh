#!/bin/sh
# Make a Beatles Bench clone record a model's refusal as a gap, as it already records an HTTP 4xx refusal.
#   scripts/bench-refusals-as-gaps.sh BENCH_DIR
# At bench commit 40e9384c, scripts/run/gaps.py counts only "the backend answered with status 4xx" as a gap, so a
# question the model itself refuses ("the reply was refused: the backend refused the question", exit 4) stops the run.
# This widens that one pattern. A gap scores as a wrong answer. Run it once on the clone before scripts/bench.sh.
set -eu
sed -i 's/REFUSED = re.compile(r"the backend answered with status 4\\d\\d")/REFUSED = re.compile(r"the backend answered with status 4\\d\\d|the backend refused the question")/' \
  "$1/scripts/run/gaps.py"
grep -q 'the backend refused the question' "$1/scripts/run/gaps.py"
