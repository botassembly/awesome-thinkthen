# pplx-decider

[pplx-decider](https://docs.perplexity.ai/docs/decisions/quickstart) is Perplexity's hosted decision model. The tested model is `pplx-decider-v1-27b`. It speaks a [System One](../../apis/system1.md) dialect at Perplexity's own `decisions` path.

## Setup

- **Backend:** `perplexity`, built into ThinkThen 0.2.
- **Base address:** `https://api.perplexity.ai/v1`. ThinkThen posts to `https://api.perplexity.ai/v1/decisions`.
- **Model:** `pplx-decider-v1-27b`, the backend's default.
- **Key:** a Perplexity API key in `PERPLEXITY_API_KEY`.
- **Wrapper:** none.
- **Price:** $0.02 per million input tokens, with free output, per [Perplexity's pricing](https://docs.perplexity.ai/docs/decisions/quickstart#pricing).
- **Published limits:** 10 requests a second per organization, 128 questions, 255 options and 10 score levels a request, as ThinkThen's backend notes record them.

The scripts in [scripts/](scripts/) hold the exact commands this page reports:

- `scripts/check.sh` runs `thinkthen backends check --backend perplexity`. Add `--plan` to see the request bodies and the request bound, with nothing sent.
- `scripts/functions.sh perplexity` asks each of the ten functions one small question with the cache off and times each call. It needs `jq`.
- `scripts/bench.sh BENCH_DIR NAME [FLAG...]` asks Beatles Bench's 1,501 questions from a clone of the bench and scores them.

Each script finds the command as `thinkthen` on the path, or at `THINKTHEN_BIN`.

## Compliance check

Passed on 2026-10-13: critical 0, warning 0. ThinkThen 0.2.0, built from commit `65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16`. The check sent 14 requests and reported 2,375 input tokens. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

ThinkThen's own records show an earlier clean check on 2026-10-04.

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, hosted at `api.perplexity.ai`, load average 4.7 to 5.0 on 16 cores. One call each, with the cache off. Wall time covers the whole `thinkthen` process.

| Function | Wall time | Requests | Input tokens | Output tokens |
| --- | --- | --- | --- | --- |
| decide | 0.32 s | 1 | 142 | 1 |
| choose | 0.35 s | 1 | 144 | 1 |
| tag | 0.36 s | 1 | 619 | 4 |
| score | 0.32 s | 1 | 140 | 1 |
| filter | 0.40 s | 1 | 379 | 3 |
| rank | 0.35 s | 1 | 367 | 3 |
| find | 0.33 s | 1 | 201 | 1 |
| annotate | 0.32 s | 1 | 286 | 2 |
| recognize | 1.19 s | 2 | 2,666 | 13 |
| relate | 0.32 s | 1 | 157 | 1 |

Median 0.34 s a call. Every call answered. Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Answers: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13: full dataset 65.4%, Beatles-only 62.8%, hard set 54.1%, no refusals. Median 0.51 s a call with four calls in flight. Full report: [pplx-decider on Beatles Bench, 2026-10-13](../../reports/pplx-decider-2026-10-13.md). Answers and call times: [results/bench-2026-10-13/](results/bench-2026-10-13/).

## Cost

On 2026-10-13 the check, the timed calls and the bench together reported 223,104 input tokens over 1,545 requests: $0.0045 at the published price.

## What failed

Nothing. ThinkThen retried 19 times during the bench, and every retry succeeded.
