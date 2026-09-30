# System One

TypeSafe's decision API for Jev-style models: one endpoint, typed questions in, calibrated probabilities out, nothing generated. Published as an OpenAPI 3.1.0 schema at [api.typesafe.ai/openapi.json](https://api.typesafe.ai/openapi.json), documented at [docs.typesafe.ai/api](https://docs.typesafe.ai/api), and introduced in [Introducing System One Models and Jev](https://typesafe.ai/blog/introducing-system-one-models-and-jev) (2026-09-15).

## The shape

- One endpoint: `POST BASE/systemone`, Bearer authentication.
- One request: a `model` name, a `state` to judge (text or JSON), and `questions`, one or more named questions.
- Three question types:
  - `noul`, yes or no, answered with a probability.
  - `choice`, pick one option, answered with a probability for every option.
  - `score`, rate on a rubric, answered with a probability for every level.
- One reply: typed answers keyed by question name, each with its probabilities, and a `usage` count. No text is generated.

## Criteria, per the published schema

A question's `criteria` carry the descriptions: what each option means, or what each level means. The schema allows four description forms, and the forms differ by question type:

- `choice`: an object of option name to description, where a description is `string | object | array | null`.
- `score`: an ordered array of descriptions, each `string | object | array`. Position sets the level's score from zero.
- `noul`: an optional object with optional `true` and `false` descriptions, each `string | object | array | null`.

An object description conventionally holds `what`, `not_for`, and `examples`, none required. A `null` description means the name alone carries the meaning.

## Dialects observed

The schema is the norm; the live reference API accepts every form above (compliance check passed 2026-09-30, all rows). Two backends each reject a different corner of it:

| Backend | Refuses | Error | Observed |
| --- | --- | --- | --- |
| Liquid d1 | a `null` description on `noul` | 422, `questions.q1.criteria.false` | 2026-09-29 |
| Ollama 0.35 | an `object` description, every question type | 400, `score criteria must be an array of descriptions` | 2026-09-30 |

Strings and nulls pass on Ollama, and its own announcement example uses nulls. Strings pass on Liquid. Backends verified clean against the full check: TypeSafe Jev (2026-09-30), Kev (2026-09-29).
