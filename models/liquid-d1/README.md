# Liquid d1

[Liquid d1](https://docs.liquid.ai/lfm/models/decision-models) is a hosted decision foundation model from Liquid AI. It speaks [System One](../../apis/system1.md) natively.

## Setup

- **Backend:** `liquid`, built into ThinkThen 0.2.
- **Base address:** `https://api.liquid.ai/decisions/v1`. ThinkThen posts to `https://api.liquid.ai/decisions/v1/systemone`.
- **Model:** `d1:free`, the backend's default. Liquid also sells a paid `d1` at $0.04 per million input tokens, per ThinkThen's backend notes of 2026-10-05; this page tested only `d1:free`.
- **Key:** a Liquid AI key in `LIQUIDAI_API_KEY`, or `LIQUID_API_KEY`.
- **Wrapper:** none.
- **Price:** Liquid publishes no price for `d1:free`.

The scripts in [scripts/](scripts/) hold the exact commands this page reports:

- `scripts/check.sh` runs `thinkthen backends check --backend liquid`. Add `--plan` to see the request bodies and the request bound, with nothing sent.
- `scripts/functions.sh liquid` asks each of the ten functions one small question with the cache off and times each call. It needs `jq`.
- `scripts/bench.sh BENCH_DIR NAME [FLAG...]` asks Beatles Bench's 1,501 questions from a clone of the bench and scores them. Set `BENCH_WORKERS=1` or `2` for this backend, and pass `--timeout 120`.

Each script finds the command as `thinkthen` on the path, or at `THINKTHEN_BIN`.

## Compliance check

Passed on 2026-10-13: critical 0, warning 0. ThinkThen 0.2.0, built from commit `65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16`. The check sent 21 requests, 6 of them retries after status 429, and reported 2,107 input tokens. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

The first check, on 2026-09-29, passed every row but one. Liquid d1 refused a `null` description on a one-sided decide question with a 422 error. ThinkThen now sends a portable form of that question, and the hosted check passed clean on 2026-09-30 ([System One dialects](../../apis/system1.md#dialects-observed)).

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, hosted at `api.liquid.ai`, load average 9.4 to 10.4 on 16 cores. One call each, with the cache off. Wall time covers the whole `thinkthen` process, retries included.

| Function | Wall time | Requests | Input tokens |
| --- | --- | --- | --- |
| decide | 0.55 s | 1 | 113 |
| choose | 2.21 s | 1 | 126 |
| tag | 0.65 s | 1 | 498 |
| score | 0.65 s | 1 | 125 |
| filter | 0.68 s | 1 | 301 |
| rank | 0.68 s | 1 | 289 |
| find | 0.67 s | 1 | 164 |
| annotate | 0.80 s | 1 | 239 |
| recognize | 1.00 s | 2 | 2,327 |
| relate | 2.15 s | 2 | 156 |

Median 0.68 s a call. Every call answered. Liquid reports no output tokens. ThinkThen's usage totals counted one retry after status 429 during this run. The choose and relate calls near 2.2 s were the slow ones. Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Answers: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13 under ThinkThen 0.2: full dataset 69.3%, Beatles-only 66.5%, hard set 56.8%, no refusals in the final answers. Median 2.74 s a call. Full report: [Liquid d1 on Beatles Bench, 2026-10-13](../../reports/liquid-d1-2026-10-13.md). Answers and call times: [results/bench-2026-10-13/](results/bench-2026-10-13/).

Asked 2026-09-29: full dataset 63.8%, Beatles-only 60.4%, hard set 50.8%, median 0.26 s a request ([report](../../reports/liquid-d1-2026-09-29.md)). The new score is 5.5 points higher, outside that run's 95% interval. Replies still name `d1:free`, and Liquid publishes no version, so this list cannot tell whether the model behind the name changed.

## Cost

$0. On 2026-10-13 the check, the timed calls and the bench together reported 176,494 input tokens over 3,785 requests, 2,190 of them retries. Liquid publishes no price for `d1:free`.

## What failed

The free endpoint rate-limits hard. At four calls in flight it answered status 429 so often that ThinkThen's three retries ran out on 62 bench questions, and three calls ended on an attempt timeout, 30 seconds twice and 120 seconds once. Asking the refused questions again at one call in flight answered all of them. The retained check of 2026-10-02 in ThinkThen's backend notes saw the same pattern: 52 retries over 1,501 questions.
