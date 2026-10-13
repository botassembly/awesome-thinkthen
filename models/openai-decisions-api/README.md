# OpenAI Decisions API

[OpenAI's Decisions API](https://developers.openai.com/api/docs/guides/decisions) answers questions about text with a probability for each answer. It is in public beta, and its one model is `gpt-6-luna`. It does not speak System One. ThinkThen 0.2 speaks its own shape through the built-in `openai` backend, described in [Decisions API](../../apis/decisions-api.md).

## Setup

- **Backend:** `openai`, built into ThinkThen 0.2.
- **Base address:** `https://api.openai.com/v1`. ThinkThen posts to `https://api.openai.com/v1/decisions`.
- **Model:** `gpt-6-luna`, the backend's default and the only model the API accepts.
- **Key:** an OpenAI API key in `OPENAI_API_KEY`. The account needs paid credit.
- **Wrapper:** none.
- **Price:** $0.10 per million input tokens, with free output, per [OpenAI's guide](https://developers.openai.com/api/docs/guides/decisions). Regional processing and long inputs cost more.

The scripts in [scripts/](scripts/) hold the exact commands this page reports:

- `scripts/check.sh` runs `thinkthen backends check --backend openai`. Add `--plan` to see the request bodies and the request bound, with nothing sent.
- `scripts/functions.sh openai` asks each of the ten functions one small question with the cache off and times each call. It needs `jq`.
- `scripts/bench-refusals-as-gaps.sh BENCH_DIR` changes one line in a Beatles Bench clone so that a question the model refuses is scored as a gap. Run it before the bench; see "What failed" below.
- `scripts/bench.sh BENCH_DIR NAME [FLAG...]` asks Beatles Bench's 1,501 questions from a clone of the bench and scores them.
- `scripts/raw-request.sh` sends one request with curl and prints OpenAI's own error text, which ThinkThen does not print.

Each script finds the command as `thinkthen` on the path, or at `THINKTHEN_BIN`.

## Compliance check

Passed on 2026-10-13: critical 0, warning 0. ThinkThen 0.2.0, built from commit `ccb2b579f2a1aa88a0e0fe2a21416f673fbdda4f`. The check sent 15 requests and reported 3,424 input tokens and no output tokens. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

The report's `provider` line reads `systemone`, although ThinkThen sends OpenAI's request shape: `input` holds the text, and each question is a `predicate`, `choice` or `score` with a `name`.

An earlier check the same day, from commit `65ce9d5af`, failed with critical 14 because the account had no credit yet. OpenAI answered status 429 with error type `insufficient_quota`. Output: [results/check-2026-10-13-no-credit.txt](results/check-2026-10-13-no-credit.txt).

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, hosted at `api.openai.com`, load average about 18 on 16 cores from other work. One call each, with the cache off. Wall time covers the whole `thinkthen` process. OpenAI reports no output tokens.

| Function | Wall time | Requests | Input tokens |
| --- | --- | --- | --- |
| decide | 0.23 s | 1 | 209 |
| choose | 0.17 s | 1 | 168 |
| tag | 0.17 s | 1 | 840 |
| score | 0.20 s | 1 | 164 |
| filter | 0.16 s | 1 | 560 |
| rank | 0.17 s | 1 | 548 |
| find | 0.16 s | 1 | 208 |
| annotate | 0.16 s | 1 | 364 |
| recognize | 0.51 s | 2 | 3,017 |
| relate | 0.23 s | 1 | 212 |

Median 0.17 s a call. Every call answered. In "Maria Chen joined Northwind Freight in Chicago last spring", recognize found only "Maria" and "Chicago"; the other hosted models found "Maria Chen" and "Northwind Freight" too. Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Answers: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13: full dataset 88.2%, Beatles-only 87.1%, hard set 83.2%. The model refused 9 questions, and each scores as wrong. Median 0.26 s a call with four calls in flight. Full report: [OpenAI Decisions API on Beatles Bench, 2026-10-13](../../reports/openai-decisions-api-2026-10-13.md). Answers, call times and the refused questions: [results/bench-2026-10-13/](results/bench-2026-10-13/).

## Cost

On 2026-10-13 the check, the timed calls and the bench together reported 265,926 input tokens over 1,528 requests: $0.027 at the published price. The failed check before the credit was added cost nothing.

## What failed

The model refused 9 bench questions, among them who sang lead on four Beatles songs. ThinkThen reports each as "the reply was refused: the backend refused the question" and exits 4. Beatles Bench at commit `40e9384c` treats only an HTTP 4xx status as a refusal, so the first refusal stopped the run. `scripts/bench-refusals-as-gaps.sh` widens that rule in the clone, and the run then finished with the 9 recorded in [gaps.tsv](results/bench-2026-10-13/gaps.tsv).
