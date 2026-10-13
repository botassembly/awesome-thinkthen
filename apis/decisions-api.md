# Decisions API

OpenAI's decision API. OpenAI announced it at DevDay on 2026-09-29 and documents it in its [Decisions guide](https://developers.openai.com/api/docs/guides/decisions). On 2026-10-13 the guide calls it a public beta. ThinkThen 0.2 speaks it through the built-in `openai` backend, and the [OpenAI Decisions API guide](../models/openai-decisions-api/README.md) shows how to use it.

## The shape

A request is `POST https://api.openai.com/v1/decisions` with Bearer authentication. Its body holds three members:

- `model`: the model that answers. The guide names one, `gpt-6-luna`.
- `input`: the shared evidence, as a text string or as user messages holding `input_text` and `input_image` parts. An image must travel inline as a base64 data URL; a hosted image address or a file ID is refused.
- `questions`: an ordered list. Each question has a `name` the reply echoes, a `type`, and `instructions`.

The three question types:

- `predicate`: a yes-or-no condition. The answer carries `probability`, from 0 to 1.
- `choice`: one pick from `choices`, each a `value` with an optional `description`. The answer carries `choice`, `probabilities` for every value, and `confidence`.
- `score`: a rating on ordered `levels`, each a `label` with an optional `description`. The answer carries `score`, the probability-weighted average of the level indexes from 0, along with `probabilities` and `confidence`.

The reply lists one answer per question, in order, each with its `name` and `type`. An answer of type `refusal` means the model declined that question.

Unlike [System One](system1.md), there is no `state` member and no `criteria` map. A yes-or-no side's meaning travels inside the instructions. ThinkThen appends `True means: ...` and `False means: ...` lines when a question names them.

## Price and limits

The guide prices `gpt-6-luna` decisions at $0.10 per million input tokens, with no charge for output, cache reads or cache writes. Regional processing in the United States or Europe and long inputs cost more. The guide states no limit on questions, choices, levels or images per request.

## Observed on 2026-10-13

These facts come from ThinkThen 0.2.0 at commit `ccb2b579f` against `gpt-6-luna`, asked from a Beelink running Linux:

- The check passed, critical 0, warning 0, and every one of the ten functions answered.
- Replies name `gpt-6-luna` and report input tokens. They report no output tokens.
- The model refused 9 of Beatles Bench's 1,501 questions with a `refusal` answer, most of them about who sang lead on a song. No System One backend on this list has refused a bench question. ThinkThen reports a refusal as a failed answer and exits 4; it never reads one as no.
- An account with no credit answers status 429 with error type `insufficient_quota`. ThinkThen 0.2 retries that status as if it were a rate limit.

## Backends that speak it

| Backend | Check | Date |
| --- | --- | --- |
| [OpenAI Decisions API](../models/openai-decisions-api/README.md), `gpt-6-luna` | passed, critical 0, warning 0 | 2026-10-13 |
