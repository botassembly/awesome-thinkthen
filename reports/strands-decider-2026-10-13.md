# Strands Decider 2B on Beatles Bench

- **Asked:** 2026-10-13. **Where:** Local, a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB), served by `strands-decider serve --device mlx` at source `75c9fd32` with checkpoint `strands-decider-2B-hobson-v19` revision `bb282d78`. ThinkThen ran on the same machine.
- **Compliance:** `thinkthen backends check --backend mlx` on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: critical 0, warning 3 (the expected description warnings), all ten functions answered.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 36.8%, Beatles-only 35.0%, hard set 32.1%.
- **Time:** median 0.071 s a request, four calls in flight, 1,501 questions in 40 s. **Tokens:** 176,431 input. **Cost:** $0, local compute.
- **Refusals:** none.
- **Source:** Beatles Bench commit `40e9384c`, knowledge questions only, asked with `scripts/run/thinkthen.sh live` as `./run.sh` asks them. The answers ship with the guide as [bench-2026-10-13-answers.jsonl](../models/strands-decider/results/bench-2026-10-13-answers.jsonl), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share) by [bench-summary.py](../models/scripts/bench-summary.py).

Load average 6.97 at the start and 6.73 at the end on 18 cores, with other work on the machine. The bench names no backend, so its questions travelled as authored rather than through the `mlx` text workaround. The bench's runner reads `/proc/loadavg`, which macOS lacks, so this run read the load with Python's `os.getloadavg()` instead; no other line of the bench changed.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.500 |
| forward | 0.205 |
| lead-set | 0.596 |
| lexical-trap | 0.278 |
| lexical-trap-control | 0.278 |
| multi-hop | 0.394 |
| near-neighbor | 0.483 |
| near-neighbor-control | 0.300 |
| none-of-these | 0.367 |
| reversal | 0.354 |
| reversal-general | 0.390 |
| reversal-general-shared-name | 0.857 |
| reverse | 0.384 |
| shared-lead | 0.500 |
| single-hop | 0.282 |

How to use this model with ThinkThen: [its guide](../models/strands-decider/README.md). Back to [every run](../runs.md).
