# tev1

[tev1](https://ollama.com/library/tev1) is a family of experimental decision models from Together AI, fine-tuned from Qwen3.5, in two sizes: 4B (`tev1:4b`, also `tev1:latest`) and 0.8B (`tev1:0.8b`). Ollama serves both on System One. The library page calls the dataset builders and training scripts MIT licensed and states no license for the weights.

## Setup

- **Server:** Ollama 0.40.3, which answers `POST /v1/systemone`. The library page asks for Ollama 0.35 or later. ThinkThen reaches it with its built-in `ollama` backend.
- **Weights:** `tev1:4b`, 4.4 GB, digest `4d24c6f6d61a`; `tev1:0.8b`, 0.8 GB, digest `d6e7bb9bfe0f`. Ollama 0.40.3 runs both on its MLX runner, with a 2,048-token context. Loaded, `ollama ps` reported 12 GB for the 4B and 9.7 GB for the 0.8B.
- **Machine:** tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4).
- **Base address:** `http://localhost:11434/v1`, the `ollama` built-in's default.
- **Model name:** `tev1:4b` or `tev1:0.8b`. The built-in's default model is `nimble`, so name the model.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when `OLLAMA_API_KEY` is unset.
- **Descriptions:** the `ollama` built-in sends each description object as its `what` text, a workaround for an Ollama bug, and the check warns about it. Ollama 0.40.3 still needs it: the same check with the unnamed `--url` path, which sends descriptions as authored, failed with status 400 on the three probes that carry description objects ([check-4b-authored-2026-10-13.txt](results/check-4b-authored-2026-10-13.txt)). Always name `--backend ollama`.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder on a Mac:

```
models/scripts/install-ollama.sh
models/scripts/start-ollama.sh
```

Then, in a second terminal in the same folder, [pull.sh](scripts/pull.sh) pulls both sizes. [install-ollama.sh](../scripts/install-ollama.sh) downloads the Ollama command into the folder, and [start-ollama.sh](../scripts/start-ollama.sh) serves it on 127.0.0.1:11434 with its models in the same folder. The desktop app from ollama.com serves the same address.

## Compliance check

Run [check.sh](scripts/check.sh) with the size while Ollama runs:

```
thinkthen backends check --backend ollama --model tev1:4b
thinkthen backends check --backend ollama --model tev1:0.8b
```

Both passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 3, exit 0. The three warnings are the expected description warnings. Full output: [4B](results/check-4b-2026-10-13.txt), [0.8B](results/check-0.8b-2026-10-13.txt).

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average 7.6 to 8.8 on 18 cores, every call exited 0:

| Function | 4B seconds | 4B answer | 0.8B seconds | 0.8B answer |
| --- | --- | --- | --- | --- |
| decide | 0.080 | true | 0.051 | true |
| choose | 0.093 | billing | 0.037 | billing |
| tag | 0.212 | damage, refund_request | 0.105 | damage, refund_request, wrong_item |
| score | 0.080 | 1.19 | 0.042 | 1.30 |
| filter | 0.161 | ISS-101 | 0.053 | ISS-101 |
| rank | 0.162 | ISS-101, ISS-103, ISS-102 | 0.056 | ISS-101, ISS-103, ISS-102 |
| find | 0.102 | Standard delivery arrives in two to four working days. | 0.047 | the same line |
| annotate | 0.118 | refund true, team billing | 0.094 | refund true, team billing |
| recognize | 0.650 | Maria Chen, person | 0.403 | no names found |
| relate | 0.071 | no relation passed | 0.046 | works_for, 0.56 |

Scores run from 0 (calm) to 2 (angry). Wall seconds include starting the command. The 4B finds only one of the three names in the recognize sentence, and the 0.8B finds none. Rows and answers: [4B](results/functions-4b-2026-10-13.tsv) ([answers](results/functions-4b-2026-10-13-answers.txt)), [0.8B](results/functions-0.8b-2026-10-13.tsv) ([answers](results/functions-0.8b-2026-10-13-answers.txt)).

## Beatles Bench

Asked 2026-10-13 through `--backend ollama`, no refusals:

- tev1 4B: full dataset 43.6%, Beatles-only 40.3%, hard set 33.7%. Full report: [tev1 4B on Beatles Bench, 2026-10-13](../../reports/tev1-4b-2026-10-13.md).
- tev1 0.8B: full dataset 36.8%, Beatles-only 35.7%, hard set 31.3%. Full report: [tev1 0.8B on Beatles Bench, 2026-10-13](../../reports/tev1-0.8b-2026-10-13.md).

## Timings

- Ten functions, 2026-10-13, M5 Max: 4B 0.07 to 0.21 s a call, recognize 0.65 s; 0.8B 0.04 to 0.11 s a call, recognize 0.40 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine, four calls in flight: 4B a median of 0.21 s a request, 1,501 questions in 83 s, load average 8.19 to 10.48 on 18 cores; 0.8B a median of 0.077 s, 40 s, load 7.79 to 8.51.
- Cost: $0, local compute.
