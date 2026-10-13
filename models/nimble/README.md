# nimble

[nimble](https://ollama.com/library/nimble) is a 9B decision model from Bespoke Labs, fine-tuned from Qwen3.5-9B, with Apache 2.0 weights. Ollama serves it on System One, and it is the default model of ThinkThen's built-in `ollama` backend.

## Setup

- **Server:** Ollama 0.40.3, which answers `POST /v1/systemone`. The library page asks for Ollama 0.35 or later. ThinkThen reaches it with its built-in `ollama` backend.
- **Weights:** `nimble:latest`, the same model as `nimble:9b`, 9.3 GB, digest `13ae0a506102`. Ollama 0.40.3 runs it on its MLX runner with an 8,192-token context; loaded, `ollama ps` reported 17 GB. The library page says each question's full prompt must fit that context.
- **Machine:** tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4).
- **Base address:** `http://localhost:11434/v1`, the `ollama` built-in's default.
- **Model name:** `nimble`, the built-in's default model.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when `OLLAMA_API_KEY` is unset.
- **Descriptions:** the `ollama` built-in sends each description object as its `what` text, a workaround for an Ollama bug, and the check warns about it. The [tev1 guide](../tev1/README.md) shows Ollama 0.40.3 still refusing description objects, so always name `--backend ollama`.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder on a Mac:

```
models/scripts/install-ollama.sh
models/scripts/start-ollama.sh
```

Then, in a second terminal in the same folder, [pull.sh](scripts/pull.sh) pulls nimble. [install-ollama.sh](../scripts/install-ollama.sh) downloads the Ollama command into the folder, and [start-ollama.sh](../scripts/start-ollama.sh) serves it on 127.0.0.1:11434 with its models in the same folder. The desktop app from ollama.com serves the same address.

## Compliance check

Run [check.sh](scripts/check.sh) while Ollama runs:

```
thinkthen backends check --backend ollama
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 3, exit 0. The three warnings are the expected description warnings. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt).

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average about 9.1 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.116 | true |
| choose | 0.114 | billing |
| tag | 0.341 | damage, refund_request |
| score | 0.099 | 0.95, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.241 | ISS-101 |
| rank | 0.221 | ISS-101, ISS-103, ISS-102 |
| find | 0.138 | Standard delivery arrives in two to four working days. |
| annotate | 0.188 | refund true, team billing |
| recognize | 1.794 | Maria Chen, person; Northwind Freight, organization; Chicago, place |
| relate | 0.098 | works_for, Maria Chen to Northwind Freight, 0.73 |

Wall seconds include starting the command. nimble is the only local model on this list that gave the expected answer to all ten. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13 through `--backend ollama`: full dataset 52.6%, Beatles-only 49.1%, hard set 43.5%, no refusals. Full report: [nimble on Beatles Bench, 2026-10-13](../../reports/nimble-2026-10-13.md).

## Timings

- Ten functions, 2026-10-13, M5 Max: 0.10 to 0.34 s a call, recognize 1.79 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine: median 0.31 s a request, four calls in flight, 1,501 questions in 124 s, load average 8.61 at the start and 5.76 at the end on 18 cores.
- Cost: $0, local compute.
