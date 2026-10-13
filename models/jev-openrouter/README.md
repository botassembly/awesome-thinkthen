# Jev through OpenRouter

[OpenRouter](https://openrouter.ai/) resells TypeSafe's [Jev](../jev/README.md) on its own [System One](../../apis/system1.md) endpoint, so one OpenRouter key reaches Jev. The model name is `typesafe/jev-1.13`, and replies name `typesafe/jev-1.13-20260917`.

## Setup

- **Backend:** `openrouter`, built into ThinkThen 0.2. It always sends both sides of a yes-or-no question, which OpenRouter requires.
- **Base address:** `https://openrouter.ai/api/v1`. ThinkThen posts to `https://openrouter.ai/api/v1/systemone`.
- **Model:** `typesafe/jev-1.13`, the backend's default.
- **Key:** an OpenRouter API key in `OPENROUTER_API_KEY`.
- **Wrapper:** none.
- **Price:** $0.042 per million input tokens, with free output, the same as TypeSafe's own price.

The scripts in [scripts/](scripts/) hold the exact commands this page reports:

- `scripts/check.sh` runs `thinkthen backends check --backend openrouter`. Add `--plan` to see the request bodies and the request bound, with nothing sent. Add `--model NAME` to check another OpenRouter model.
- `scripts/functions.sh openrouter` asks each of the ten functions one small question with the cache off and times each call. It needs `jq`.
- `scripts/bench.sh BENCH_DIR NAME [FLAG...]` asks Beatles Bench's 1,501 questions from a clone of the bench and scores them.
- `scripts/raw-request-jev-router.sh` sends one request for `typesafe/jev-router` with curl and prints OpenRouter's own error text.

Each script finds the command as `thinkthen` on the path, or at `THINKTHEN_BIN`.

## Compliance check

Passed on 2026-10-13: critical 0, warning 0. ThinkThen 0.2.0, built from commit `65ce9d5af630fc3a4b7b6c553716cc3c2ea3ad16`. The check sent 15 requests and reported 5,146 input tokens. Output: [results/check-2026-10-13.txt](results/check-2026-10-13.txt).

ThinkThen's own records show an earlier clean check on 2026-10-04.

## `typesafe/jev-router` does not work with ThinkThen

OpenRouter also lists `typesafe/jev-router`. Its model page describes a router that picks a model and a reasoning effort for each request, with a variable price and chat parameters. It is a chat-completions model, not a decision model.

`scripts/check.sh --model typesafe/jev-router` failed on 2026-10-13: critical 14, warning 0. Connection, key and endpoint passed, and every probe and function met status 400. Output: [results/check-jev-router-2026-10-13.txt](results/check-jev-router-2026-10-13.txt). ThinkThen does not print a provider's error text, so one request went out with curl; OpenRouter answered "Model typesafe/jev-router does not exist" on its System One endpoint. Use `typesafe/jev-1.13`.

## Timings

Asked 2026-10-13 from a Beelink mini PC running Linux, hosted at `openrouter.ai`, load average 4.1 to 4.3 on 16 cores. One call each, with the cache off. Wall time covers the whole `thinkthen` process.

| Function | Wall time | Requests | Input tokens | Output tokens |
| --- | --- | --- | --- | --- |
| decide | 0.25 s | 1 | 331 | 21 |
| choose | 0.35 s | 1 | 357 | 46 |
| tag | 0.30 s | 1 | 575 | 72 |
| score | 0.30 s | 1 | 357 | 18 |
| filter | 0.29 s | 1 | 404 | 55 |
| rank | 0.32 s | 1 | 392 | 55 |
| find | 0.26 s | 1 | 416 | 61 |
| annotate | 0.33 s | 1 | 420 | 63 |
| recognize | 0.51 s | 2 | 2,783 | 674 |
| relate | 0.26 s | 1 | 367 | 21 |

Median 0.30 s a call, about 0.12 s more than the same calls sent straight to TypeSafe on the same day. Every call answered with the same token counts as the direct route. Raw rows: [results/functions-2026-10-13.tsv](results/functions-2026-10-13.tsv). Answers: [results/functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

Asked 2026-10-13: full dataset 70.6%, Beatles-only 67.5%, hard set 56.2%, no refusals. Median 0.50 s a call with four calls in flight. Full report: [Jev through OpenRouter on Beatles Bench, 2026-10-13](../../reports/jev-openrouter-2026-10-13.md). Answers and call times: [results/bench-2026-10-13/](results/bench-2026-10-13/).

## Cost

OpenRouter's key report showed $0.022 spent on 2026-10-13. That covers both checks, the timed calls and the bench: 567,426 input tokens over 1,541 requests, as ThinkThen counted them.

## What failed

Only `typesafe/jev-router`, above. The default model never failed, and ThinkThen made no retry.
