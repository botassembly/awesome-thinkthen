# Liquid d1

[Liquid d1](https://docs.liquid.ai/lfm/models/decision-models) is a hosted decision foundation model from Liquid AI. It speaks [System One](../../apis/system1.md) natively.

## Setup

- **Base address:** the host is `api.liquid.ai`. The full base address, with its path, is not yet recorded here.
- **Model name:** `d1:free`. On 2026-09-29 the endpoint listed this one model and published no price.
- **Key:** a Liquid AI key. The environment variable ThinkThen 0.2 reads it from is not yet recorded here.
- **Wrapper:** none.

Check the backend with:

```
thinkthen check --url LIQUID_BASE_URL --model d1:free
```

`LIQUID_BASE_URL` stands for the full base address above. This list has not yet recorded that exact command and its output against ThinkThen 0.2.

## Compliance check

Passed: critical 0, warning 0, on 2026-09-30.

The first check, on 2026-09-29, passed every row but one. Liquid d1 refused a `null` description on a one-sided decide question with a 422 error. ThinkThen now sends a portable form of that question, and the hosted check passed clean the next day ([System One dialects](../../apis/system1.md#dialects-observed)). The list does not record which ThinkThen version ran either check.

## Beatles Bench

Asked 2026-09-29: full dataset 63.8%, Beatles-only 60.4%, hard set 50.8%, no refusals. Full report: [Liquid d1 on Beatles Bench, 2026-09-29](../../reports/liquid-d1-2026-09-29.md).

## Timings

- Beatles Bench, 2026-09-29, hosted at `api.liquid.ai`: median 0.26 s a request. One backend timeout on the first question cleared on a retry at two workers.
- Cost on that run: $0, because the endpoint published no price.
- A short timed run of each ThinkThen function: not yet measured.
