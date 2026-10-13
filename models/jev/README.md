# Jev

[Jev](https://docs.typesafe.ai/) is TypeSafe's hosted decision model and the model ThinkThen was built on. It speaks [System One](../../apis/system1.md) natively.

## Setup

- **Backend:** `typesafe`, built into ThinkThen 0.2.
- **Base address:** `https://api.typesafe.ai/v1`. ThinkThen posts to `https://api.typesafe.ai/v1/systemone` with Bearer authentication. The paper [2609.28940](../../papers/2609.28940.md) shows that address in its code listings.
- **Model:** `jev-1.13.0`, the backend's default. TypeSafe also accepts `jev-latest`, per the same paper.
- **Key:** a TypeSafe API key in `TYPESAFE_API_KEY` when you name the `typesafe` backend, or in `THINKTHEN_API_KEY` when you name no backend. Jev is ThinkThen's default address, so `THINKTHEN_API_KEY` alone reaches it.
- **Wrapper:** none.
- **Price:** $0.042 per million input tokens, with free output.

The scripts in [scripts/](scripts/) hold the exact commands this page reports:

- `scripts/check.sh` runs `thinkthen backends check --backend typesafe`. Add `--plan` to see the request bodies and the request bound, with nothing sent.
- `scripts/functions.sh typesafe` asks each of the ten functions one small question with the cache off and times each call. It needs `jq`.
- `scripts/bench.sh BENCH_DIR NAME [FLAG...]` asks Beatles Bench's 1,501 questions from a clone of the bench and scores them.

Each script finds the command as `thinkthen` on the path, or at `THINKTHEN_BIN`.

## Compliance check

Passed on 2026-10-13: critical 0, warning 0. ThinkThen 0.2.0, built from commit `65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16`. The check sent 15 requests and reported 5,131 input tokens. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

Earlier checks passed clean on 2026-09-23 and 2026-09-30 ([System One dialects](../../apis/system1.md#dialects-observed)); the list does not record which ThinkThen version ran those.

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, hosted at `api.typesafe.ai`, load average 3.0 to 4.3 on 16 cores. One call each, with the cache off. Wall time covers the whole `thinkthen` process.

| Function | Wall time | Requests | Input tokens | Output tokens |
| --- | --- | --- | --- | --- |
| decide | 0.14 s | 1 | 331 | 21 |
| choose | 0.26 s | 1 | 357 | 46 |
| tag | 0.15 s | 1 | 575 | 72 |
| score | 0.16 s | 1 | 357 | 18 |
| filter | 0.17 s | 1 | 404 | 55 |
| rank | 0.18 s | 1 | 392 | 55 |
| find | 0.20 s | 1 | 416 | 61 |
| annotate | 0.16 s | 1 | 420 | 63 |
| recognize | 0.31 s | 2 | 2,783 | 674 |
| relate | 0.19 s | 1 | 367 | 21 |

Median 0.18 s a call. Every call answered. Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Answers: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

Asked 2026-10-13 under ThinkThen 0.2: full dataset 69.8%, Beatles-only 66.6%, hard set 55.7%, no refusals. Median 0.32 s a call with four calls in flight. Full report: [Jev on Beatles Bench, 2026-10-13](../../reports/jev-2026-10-13.md). Answers and call times: [results/bench-2026-10-13/](results/bench-2026-10-13/).

Asked 2026-09-26: full dataset 70.2%, Beatles-only 67.0%, hard set 55.9%, median 0.21 s a request ([report](../../reports/jev-2026-09-26.md)).

## Cost

On 2026-10-13 the check, the timed calls and the bench together reported 574,879 input tokens over 1,546 requests: $0.024 at the published price.

## What failed

Two bench calls of 2026-10-13 ended on ThinkThen's 30-second attempt timeout. ThinkThen never resends a request after a transport failure, because the backend may already hold it and bill it, so each stopped the run. Running `scripts/bench.sh` again the same day resumed from the recording; the last pass added `--timeout 120` and finished with no failure.
