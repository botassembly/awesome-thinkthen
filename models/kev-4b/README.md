# Kev-4B

[Kev](https://github.com/jaredpalmer/kev) is a family of open decision models built on Qwen, from 0.8B to 27B, with its own System One server. This guide covers Kev-4B, the size the list has tested, on two servers: Kev's own server, and llama.cpp with the [GGUF conversion](https://huggingface.co/ggml-org/Kev-4B-GGUF) that ggml-org publishes. Both carry Apache 2.0 licenses.

Both servers were tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4), with ThinkThen on the same machine.

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

## Kev's own server

- **Server:** `kev.serve` from the Kev repository at commit `85ccf56a`, version 0.1.0. On Apple silicon it runs Kev's checkpoints under MLX (0.32.2 here).
- **Weights:** `jaredpalmer/kev-4b`, a LoRA adapter and decision head at revision `6cfce5c2`, on the base `Qwen/Qwen3.5-4B-Base` at revision `1001bb4d`. The first start downloads both, about 9 GB. The server process held 8.2 GiB resident after the bench.
- **Base address:** `http://127.0.0.1:8009/v1`. The server binds to 127.0.0.1 unless told otherwise.
- **Model name:** `kev-latest`, the name Kev's README uses and the name its replies carry.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when none is set.

In an empty folder, with git and [uv](https://docs.astral.sh/uv/) installed:

```
models/kev-4b/scripts/install.sh
models/kev-4b/scripts/start.sh
```

[install.sh](scripts/install.sh) clones Kev at the tested commit and runs `uv sync --extra serve`. [start.sh](scripts/start.sh) runs `python -m kev.serve --run jaredpalmer/kev-4b --port 8009`. It fetches the newest Kev-4B revision; Kev's README names `jaredpalmer/kev-4b@v1.0` to pin the 1.0 release. On a slow connection the server's own download can stall; `hf download Qwen/Qwen3.5-4B-Base` from Kev's environment fetches the base first, and the server then finds it in the Hugging Face cache.

### Compliance check

Run [check.sh](scripts/check.sh) while the server runs:

```
thinkthen backends check --url http://127.0.0.1:8009/v1 --model kev-latest
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 0, exit 0. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt). An earlier check against the same server passed on 2026-09-29 with an unrecorded ThinkThen version.

### The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, load average about 6.8 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.061 | true |
| choose | 0.059 | other |
| tag | 0.110 | damage, refund_request |
| score | 0.064 | 0.87, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.089 | ISS-101 |
| rank | 0.093 | ISS-101, ISS-102, ISS-103 |
| find | 0.106 | Standard delivery arrives in two to four working days. |
| annotate | 0.087 | refund true, team other |
| recognize | 0.644 | no names found |
| relate | 0.111 | works_for, Maria Chen to Northwind Freight, 0.58 |

Wall seconds include starting the command. Kev-4B routes the refund to `other` rather than `billing`, and recognizes no names in a sentence with a person, a company and a city. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

### Beatles Bench

Asked 2026-10-13: full dataset 47.9%, Beatles-only 44.9%, hard set 39.8%, no refusals. Full report: [Kev-4B on Beatles Bench, 2026-10-13](../../reports/kev-4b-2026-10-13.md). The run of 2026-09-29 through the same server scored 47.2% ([report](../../reports/kev-4b-2026-09-29.md)).

## llama.cpp

- **Server:** llama.cpp's `llama-server`, release b11588, which answers `POST /v1/systemone`. ThinkThen reaches it with its built-in `llamacpp` backend.
- **Weights:** `Kev-4B-Q4_K_M.gguf`, 3.0 GB, at revision `d924f2e2`.
- **Base address:** `http://localhost:8080/v1`, the built-in's default. **Model name:** `local`, set by `--alias local`. **Key:** none.
- **Server settings:** context, batch and physical batch 4096, one slot.

In an empty folder on a Mac with Apple silicon:

```
models/scripts/install-llamacpp.sh
models/kev-4b/scripts/start-llamacpp.sh
```

[start-llamacpp.sh](scripts/start-llamacpp.sh) downloads the weights once and starts the server on port 8080. The server log names `decision model type: kev` when the weights load as a decision model. [check-llamacpp.sh](scripts/check-llamacpp.sh) runs `thinkthen backends check --backend llamacpp --timeout 120`. It passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: critical 0, warning 0, exit 0, all ten functions answered ([check-llamacpp-2026-10-13.txt](results/check-llamacpp-2026-10-13.txt)).

[functions-llamacpp.sh](scripts/functions-llamacpp.sh) took 0.07 to 0.23 s a call, except recognize at 1.01 s, on 2026-10-13 with load average about 7.0. The answers match Kev's own server except the score, 0.80, and the order of the two lower-ranked issues ([functions-llamacpp-2026-10-13.tsv](results/functions-llamacpp-2026-10-13.tsv), [answers](results/functions-llamacpp-2026-10-13-answers.txt)).

On Beatles Bench the same day it scored 46.9% on the full dataset, 43.6% Beatles-only and 37.0% on the hard set, with no refusals, a median of 0.21 s a request, 1,501 questions in 85 s ([summary](results/bench-llamacpp-2026-10-13.txt), [answers](results/bench-llamacpp-2026-10-13-answers.jsonl)). The quantized weights cost about one point against Kev's own server.

## Timings

- Ten functions, 2026-10-13, M5 Max: Kev's own server 0.06 to 0.11 s a call, recognize 0.64 s; llama.cpp 0.07 to 0.23 s a call, recognize 1.01 s.
- Beatles Bench, 2026-10-13, M5 Max: Kev's own server a median of 0.19 s a request, four calls in flight, 1,501 questions in 75 s, load average 7.13 at the start and 9.13 at the end on 18 cores; llama.cpp 0.21 s, 85 s, load 6.76 to 7.70.
- Beatles Bench, 2026-09-29, Kev's own server on the M5 through an SSH tunnel: median 0.20 s a request.
- Cost: $0, local compute.
