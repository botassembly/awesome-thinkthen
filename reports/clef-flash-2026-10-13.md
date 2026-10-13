# Clef-Flash on Beatles Bench

- **Asked:** 2026-10-13. **Where:** Local, a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB), served by llama.cpp release b11588 from `Clef-Flash-Q4_K_M.gguf`, one slot. ThinkThen ran on the same machine.
- **Compliance:** `thinkthen backends check --backend llamacpp` on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: critical 0, warning 0, all ten functions answered.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 53.4%, Beatles-only 50.4%, hard set 43.4%.
- **Time:** median 0.60 s a request, four calls in flight against one server slot, 1,501 questions in 219 s. **Tokens:** 306,983 input. **Cost:** $0, local compute.
- **Refusals:** none.
- **Source:** Beatles Bench commit `40e9384c`, knowledge questions only, asked with `scripts/run/thinkthen.sh live` as `./run.sh` asks them. The answers ship with the guide as [bench-2026-10-13-answers.jsonl](../models/clef-flash/results/bench-2026-10-13-answers.jsonl), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share) by [bench-summary.py](../models/scripts/bench-summary.py).

Load average 5.16 at the start and 6.89 at the end on 18 cores, with other work on the machine. The first open-weights model on this list above 50% on the full dataset. The bench's runner reads `/proc/loadavg`, which macOS lacks, so this run read the load with Python's `os.getloadavg()` instead; no other line of the bench changed.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.683 |
| forward | 0.438 |
| lead-set | 0.596 |
| lexical-trap | 0.370 |
| lexical-trap-control | 0.481 |
| multi-hop | 0.478 |
| near-neighbor | 0.567 |
| near-neighbor-control | 0.583 |
| none-of-these | 0.333 |
| reversal | 0.446 |
| reversal-general | 0.692 |
| reversal-general-shared-name | 0.905 |
| reverse | 0.438 |
| shared-lead | 0.500 |
| single-hop | 0.589 |

How to use this model with ThinkThen: [its guide](../models/clef-flash/README.md). Back to [every run](../runs.md).
