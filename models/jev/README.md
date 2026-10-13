# Jev

[Jev](https://docs.typesafe.ai/) is TypeSafe's hosted decision model and the model ThinkThen was built on. It speaks [System One](../../apis/system1.md) natively.

## Setup

- **Base address:** `https://api.typesafe.ai/v1`. System One takes requests at `POST BASE/systemone`, so Jev answers at `https://api.typesafe.ai/v1/systemone` with Bearer authentication. The paper [2609.28940](../../papers/2609.28940.md) shows that address in its code listings.
- **Model name:** `jev-1.13.0` ran the Beatles Bench run of 2026-09-26. TypeSafe also accepts `jev-latest`, per the same paper.
- **Key:** a TypeSafe API key in `TYPESAFE_API_KEY` when you name the built-in `typesafe` backend, or in `THINKTHEN_API_KEY` when you name no backend. Jev is ThinkThen's default address, so `THINKTHEN_API_KEY` alone reaches it.
- **Wrapper:** none.

Check the backend with:

```
thinkthen backends check --backend typesafe
```

This list has not yet recorded that exact command and its output against ThinkThen 0.2.

## Compliance check

Passed: critical 0, warning 0. First recorded 2026-09-23, and verified clean again against the full check on 2026-09-30 ([System One dialects](../../apis/system1.md#dialects-observed)). The list does not record which ThinkThen version ran either check.

## Beatles Bench

Asked 2026-09-26: full dataset 70.2%, Beatles-only 67.0%, hard set 55.9%, no refusals. Full report: [Jev on Beatles Bench, 2026-09-26](../../reports/jev-2026-09-26.md).

## Timings

- Beatles Bench, 2026-09-26, hosted at `api.typesafe.ai`: median 0.21 s a request, with the client machine's load average between 3.83 and 7.10 on 16 cores.
- Cost on that run: $0.015 per 1,000 questions, at $0.042 per million input tokens with free output.
- A short timed run of each ThinkThen function: not yet measured.
