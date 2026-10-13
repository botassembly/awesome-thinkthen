# gpt-6-luna, OpenAI Decisions API

[OpenAI's Decisions API](https://developers.openai.com/api/docs/guides/decisions) answers developer-defined questions with a probability for each answer. Its model is `gpt-6-luna`. It does not speak System One. ThinkThen 0.2 speaks its own shape through the built-in `openai` backend, described in [Decisions API](../../apis/decisions-api.md).

**Status: tested, not yet working.** The check of 2026-10-13 failed because the OpenAI account used for the test had no credit. Nothing was answered and nothing was billed. The list has no evidence yet about how gpt-6-luna answers.

## Setup

- **Backend:** `openai`, built into ThinkThen 0.2.
- **Base address:** `https://api.openai.com/v1`. ThinkThen posts to `https://api.openai.com/v1/decisions`.
- **Model:** `gpt-6-luna`, the backend's default.
- **Key:** an OpenAI API key in `OPENAI_API_KEY`. The account needs paid credit.
- **Wrapper:** none.
- **Price:** $0.10 per million input tokens, with free output, per [OpenAI's guide](https://developers.openai.com/api/docs/guides/decisions).

The scripts in [scripts/](scripts/) hold the exact commands:

- `scripts/check.sh` runs `thinkthen backends check --backend openai`. Add `--plan` to see the request bodies and send nothing.
- `scripts/functions.sh openai` asks each of the ten functions one small question and times each call.
- `scripts/bench.sh BENCH_DIR NAME` asks Beatles Bench's 1,501 questions. It was not run.
- `scripts/raw-request.sh` sends one request with curl and prints OpenAI's own error text, which ThinkThen does not print.

## Compliance check

Failed on 2026-10-13: critical 14, warning 0. ThinkThen 0.2.0, built from commit `65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16`. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

The connection, key and endpoint rows passed. Every probe and every function then met status 429. The check took about three minutes, because ThinkThen retried each 429 three times: 56 requests, 42 of them retries, and 0 tokens.

One request sent with curl showed the cause. OpenAI answered status 429 with error type `insufficient_quota`, code `credit_balance_exhausted`, and the message "You have no credits remaining." The account needs credit before the check can say anything about the model.

The plan (`scripts/check.sh --plan`) shows that ThinkThen builds OpenAI's request shape: `input` holds the text, and each question is a `predicate`, `choice` or `score` with a `name`. The report's `provider` line still reads `systemone` for this backend.

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, load average about 3.8 on 16 cores. Every call failed with status 429 after four attempts, so these times measure the retries and not the model.

| Function | Exit | Wall time | Requests | Input tokens |
| --- | --- | --- | --- | --- |
| decide | 4 | 4.82 s | 4 | 0 |
| choose | 4 | 5.25 s | 4 | 0 |
| tag | 4 | 6.43 s | 4 | 0 |
| score | 4 | 5.57 s | 4 | 0 |
| filter | 4 | 6.95 s | 4 | 0 |
| rank | 4 | 5.94 s | 4 | 0 |
| find | 4 | 5.57 s | 4 | 0 |
| annotate | 4 | 4.41 s | 4 | 0 |
| recognize | 4 | 5.94 s | 4 | 0 |
| relate | 4 | 5.43 s | 4 | 0 |

Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Messages: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Cost

$0. OpenAI refused every request before answering, and every reply reported no tokens.

## Beatles Bench

Not run. The check must pass first.
