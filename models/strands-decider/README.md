# Strands Decider 2B

[Strands Decider](https://github.com/strands-labs/strands-decider) is an open decision model and server from Strands Labs. The checkpoint [strands-decider-2B-hobson-v19](https://huggingface.co/StrandsAgents/strands-decider-2B-hobson-v19) adds a decision head to Qwen3.5-2B-Base, and the server answers System One under MLX on Apple silicon. ThinkThen's built-in `mlx` backend targets this server and checkpoint. The repository carries the Apache 2.0 license.

## Setup

- **Server:** `strands-decider serve` at source commit `75c9fd32`, the commit ThinkThen's own local setup page pins, with MLX 0.32.3 and Python 3.13.13.
- **Weights:** checkpoint revision `bb282d78`, about 0.1 GB, on `Qwen/Qwen3.5-2B-Base`, about 4.3 GB. The server downloads both on its first start.
- **Machine:** tested on a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB unified memory, macOS 26.4).
- **Base address:** `http://localhost:8000/v1`, the `mlx` built-in's default.
- **Model name:** `strands-decider-2B-hobson-v19`, the checkpoint basename the server uses as its model id and the built-in's default model.
- **Key:** none. ThinkThen 0.2 sends no key to a loopback address when `MLX_API_KEY` is unset.
- **Descriptions:** the `mlx` built-in sends each description object as its `what` text, because the pinned server's schema takes strings. Other fields of a description are left out, and the check warns about it.

## Install and start

ThinkThen 0.2 is not released yet, so build it from source with [build-thinkthen.sh](../scripts/build-thinkthen.sh). The tests below used commit `65ce9d5a`, which prints `thinkthen 0.2.0`.

In an empty folder, with git and [uv](https://docs.astral.sh/uv/) installed:

```
models/strands-decider/scripts/install.sh
models/strands-decider/scripts/start.sh
```

[install.sh](scripts/install.sh) clones the server at the pinned commit and installs it with its MLX extra. [start.sh](scripts/start.sh) serves the checkpoint on port 8000.

## Compliance check

Run [check.sh](scripts/check.sh) while the server runs:

```
thinkthen backends check --backend mlx
```

Passed on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: the four rich probes passed, all ten functions answered, critical 0, warning 3, exit 0. The three warnings are the expected description warnings on the choice, score and mixed probes. Full output: [check-2026-10-13.txt](results/check-2026-10-13.txt). ThinkThen's own record shows the same setup passing on 2026-10-05 with the same three warnings.

## The ten functions

[functions.sh](scripts/functions.sh) asks each function one small question with the cache off, the same inputs the hosted guides use. On 2026-10-13, on the M5 Max with load average about 7.1 on 18 cores, every call exited 0:

| Function | Wall seconds | Answer |
| --- | --- | --- |
| decide | 0.039 | true |
| choose | 0.038 | other |
| tag | 0.079 | damage |
| score | 0.039 | 1.13, on a scale from 0 (calm) to 2 (angry) |
| filter | 0.075 | no record passed |
| rank | 0.170 | ISS-103, ISS-101, ISS-102 |
| find | 0.041 | Standard delivery arrives in two to four working days. |
| annotate | 0.058 | refund false, team other |
| recognize | 0.349 | no names found |
| relate | 0.038 | no relation passed |

Wall seconds include starting the command. The server answered every call, but many answers are wrong: decide says the customer asks for money back while annotate's nearly identical refund question says no, the defect filter passes nothing, the vague issue ranks first, and recognize finds no names. Rows and answers: [functions-2026-10-13.tsv](results/functions-2026-10-13.tsv), [functions-2026-10-13-answers.txt](results/functions-2026-10-13-answers.txt).

## Beatles Bench

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

Asked 2026-10-13: full dataset 36.8%, Beatles-only 35.0%, hard set 32.1%, no refusals. Full report: [Strands Decider 2B on Beatles Bench, 2026-10-13](../../reports/strands-decider-2026-10-13.md). The bench names no backend, so its questions travel as authored, not through the `mlx` text workaround; none was refused.

## Timings

- Ten functions, 2026-10-13, M5 Max: 0.04 to 0.17 s a call, recognize 0.35 s.
- Beatles Bench, 2026-10-13, M5 Max, ThinkThen on the same machine: median 0.071 s a request, four calls in flight, 1,501 questions in 40 s, load average 6.97 at the start and 6.73 at the end on 18 cores.
- Cost: $0, local compute.
