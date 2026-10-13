# Laya

[Laya](https://github.com/mizorewww/laya-mlx) is ModernBERT-large under MLX, about 421M parameters ([weights](https://huggingface.co/aac6fef/laya-mlx)). Laya does not speak System One itself, so a wrapper serves it.

## Setup

- **Wrapper:** [stuntdouble's sidecar](https://github.com/ReallyArtificial/stuntdouble#sidecars), `sidecars/laya.py`, serves Laya on System One. It is about 60 lines of standard-library Python.
- **Machine:** a Mac with Apple silicon and macOS 14 or later. Tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4).
- **Base address:** `http://127.0.0.1:8011/v1`. The sidecar answers `POST /v1/systemone` and `GET /health` on 127.0.0.1 only.
- **Model name:** any. The sidecar loads `aac6fef/laya-mlx` at startup and names itself `laya:laya-mlx` in every reply, whatever model the request names. The scripts send `laya-mlx`.
- **Key:** none. The sidecar checks no key, and ThinkThen 0.2 sends none to a loopback address when none is set.
- **Tested versions:** stuntdouble commit `fb9f08ec`, laya-mlx 0.4.0, MLX 0.32.3, Python 3.13.13.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder, with git and [uv](https://docs.astral.sh/uv/) installed:

```
models/laya/scripts/install.sh
models/laya/scripts/start.sh
```

[install.sh](scripts/install.sh) clones stuntdouble at the tested commit and installs laya-mlx 0.4.0 into a virtual environment. [start.sh](scripts/start.sh) starts the sidecar on port 8011. The first start downloads the weights, about 0.8 GB, from Hugging Face. On start laya-mlx warns that the checkpoint ships temperatures outside its calibrated range and clamps one of them, so it treats confidence from that bucket as uncalibrated.

## Compliance check

Run [check.sh](scripts/check.sh) while the sidecar runs:

```
thinkthen backends check --url http://127.0.0.1:8011/v1 --model laya-mlx
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 0, exit 0. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt). An earlier check through the same sidecar passed on 2026-09-30 with an unrecorded ThinkThen version.

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average about 5.4 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.041 | true |
| choose | 0.032 | billing |
| tag | 0.040 | damage, refund_request, wrong_item |
| score | 0.030 | 1.115, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.036 | no record passed |
| rank | 0.032 | ISS-103, ISS-101, ISS-102 |
| find | 0.030 | Standard delivery arrives in two to four working days. |
| annotate | 0.032 | refund true, team billing |
| recognize | 0.273 | no names found |
| relate | 0.026 | works_for, Maria Chen to Northwind Freight, 0.77 |

Wall seconds include starting the command. Laya answered every call, but several answers are wrong: it tags `wrong_item`, passes no issue through the defect filter, ranks the vague issue first, and recognizes no names in a sentence with a person, a company and a city. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

Asked 2026-10-13 through the sidecar: full dataset 34.1%, Beatles-only 33.4%, hard set 28.5%, no refusals. Full report: [Laya on Beatles Bench, 2026-10-13](../../reports/laya-2026-10-13.md). The earlier run of 2026-09-23 went through a different System One shim and scored 35.8% ([report](../../reports/laya-2026-09-23.md)).

## Timings

- Ten functions, 2026-10-13, M5 Max: 0.026 to 0.041 s a call, except recognize at 0.273 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine: median 0.044 s a request, four calls in flight, 1,501 questions in 36 s, load average 5.72 at the start and 5.84 at the end on 18 cores.
- Beatles Bench, 2026-09-23, M5 through the earlier shim and an SSH tunnel: median 0.07 s a request.
- Cost: $0, local compute.
