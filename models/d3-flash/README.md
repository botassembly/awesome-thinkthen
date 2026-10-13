# d3-flash (Decision 3.0)

[d3-flash](https://huggingface.co/vllm-sr/d3-flash) is the 9B model of Decision 3.0, the open decision models of [vLLM Semantic Router](https://github.com/vllm-project/semantic-router). It is fine-tuned from Qwen3.5-9B, has 8.39B parameters, reads text, images and video, and carries the Apache 2.0 license. llama.cpp serves it on System One from the [GGUF conversion](https://huggingface.co/ggml-org/vllm-d3-flash-GGUF) that ggml-org publishes. This guide covers text only.

## Setup

- **Server:** llama.cpp's `llama-server`, release b11588. The vllm d3 models need release b11572 or later, the first with llama.cpp's support for them. ThinkThen reaches the server with its built-in `llamacpp` backend.
- **Weights:** `vllm-d3-flash-Q4_K_M.gguf`, 6.6 GB, at revision `3d53d137`, with no vision projector.
- **Machine:** tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4). The server process held 6.6 GiB resident after the bench.
- **Base address:** `http://localhost:8080/v1`, the `llamacpp` built-in's default.
- **Model name:** `local`, set by the server's `--alias local`, which is the built-in's default model.
- **Server settings:** context, batch and physical batch 4096, one slot.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when `LLAMACPP_API_KEY` is unset.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder on a Mac with Apple silicon:

```
models/scripts/install-llamacpp.sh
models/d3-flash/scripts/start.sh
```

[install-llamacpp.sh](../scripts/install-llamacpp.sh) downloads the llama.cpp release. [start.sh](scripts/start.sh) downloads the weights once and starts the server on port 8080. The server log names `decision model type: vllm-d3` when the weights load as a decision model.

## Compliance check

Run [check.sh](scripts/check.sh) while the server runs:

```
thinkthen backends check --backend llamacpp --timeout 120
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 0, exit 0. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt).

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average about 9.5 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.128 | true |
| choose | 0.128 | billing |
| tag | 0.449 | damage, refund_request |
| score | 0.127 | 1.16, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.272 | ISS-101 |
| rank | 0.272 | ISS-101, ISS-103, ISS-102 |
| find | 0.132 | Standard delivery arrives in two to four working days. |
| annotate | 0.234 | refund true, team billing |
| recognize | 1.470 | Maria Chen, person; Northwind Freight, organization; Chicago, place |
| relate | 0.128 | no relation passed |

Wall seconds include starting the command. Every answer but one matches what a reader would expect; relate finds no `works_for` relation between Maria Chen and Northwind Freight. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

Asked 2026-10-13: full dataset 60.6%, Beatles-only 58.0%, hard set 49.1%, no refusals. Full report: [d3-flash on Beatles Bench, 2026-10-13](../../reports/d3-flash-2026-10-13.md).

## Timings

- Ten functions, 2026-10-13, M5 Max: 0.13 to 0.45 s a call, except recognize at 1.47 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine: median 0.49 s a request, 1,501 questions in 184 s, load average 9.21 at the start and 12.33 at the end on 18 cores. The bench keeps four calls in flight and the server has one slot, so the median includes time waiting in the server's queue.
- Cost: $0, local compute.
