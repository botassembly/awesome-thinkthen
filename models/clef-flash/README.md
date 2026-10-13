# Clef-Flash

[Clef-Flash](https://huggingface.co/Cloudflare/clef-flash) is Cloudflare's smaller decision model, about 9B parameters, with Apache 2.0 weights. llama.cpp serves it on System One from the [GGUF conversion](https://huggingface.co/ggml-org/Clef-Flash-GGUF) that ggml-org publishes.

## Setup

- **Server:** llama.cpp's `llama-server`, release b11588, which answers `POST /v1/systemone`. ThinkThen reaches it with its built-in `llamacpp` backend.
- **Weights:** `Clef-Flash-Q4_K_M.gguf`, 6.5 GB, at revision `4a7a08c0`, the revision ThinkThen's own local setup page pins.
- **Machine:** tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4). The server process held 6.6 GiB resident with these settings.
- **Base address:** `http://localhost:8080/v1`, the `llamacpp` built-in's default.
- **Model name:** `local`, set by the server's `--alias local`, which is the built-in's default model.
- **Server settings:** context, batch and physical batch 4096, one slot.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when `LLAMACPP_API_KEY` is unset.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder on a Mac with Apple silicon:

```
models/scripts/install-llamacpp.sh
models/clef-flash/scripts/start.sh
```

[install-llamacpp.sh](../scripts/install-llamacpp.sh) downloads the llama.cpp release. [start.sh](scripts/start.sh) downloads the weights once and starts the server on port 8080. The server log names `decision model type: clef` when the weights load as a decision model.

## Compliance check

Run [check.sh](scripts/check.sh) while the server runs:

```
thinkthen backends check --backend llamacpp --timeout 120
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 0, exit 0. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt). ThinkThen's own record shows the same setup passing on llama.cpp v0.6.0 on 2026-10-05.

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average about 5.2 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.132 | true |
| choose | 0.129 | billing |
| tag | 0.313 | damage, refund_request |
| score | 0.131 | 1.47, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.215 | ISS-101 |
| rank | 0.213 | ISS-101, ISS-103, ISS-102 |
| find | 0.135 | Standard delivery arrives in two to four working days. |
| annotate | 0.177 | refund true, team account |
| recognize | 1.261 | Maria Chen, person; Northwind Freight, organization; Chicago, place |
| relate | 0.129 | no relation passed |

Wall seconds include starting the command. Two answers differ from what a reader would expect: annotate files the refund under `account` although choose picks `billing` for the same message, and relate finds no `works_for` relation between Maria Chen and Northwind Freight. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13: full dataset 53.4%, Beatles-only 50.4%, hard set 43.4%, no refusals. Full report: [Clef-Flash on Beatles Bench, 2026-10-13](../../reports/clef-flash-2026-10-13.md).

## Timings

- Ten functions, 2026-10-13, M5 Max: 0.13 to 0.31 s a call, except recognize at 1.26 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine: median 0.60 s a request, 1,501 questions in 219 s, load average 5.16 at the start and 6.89 at the end on 18 cores. The bench keeps four calls in flight and the server has one slot, so the median includes time waiting in the server's queue.
- Cost: $0, local compute.
