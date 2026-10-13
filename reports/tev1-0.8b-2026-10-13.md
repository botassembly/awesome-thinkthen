# tev1 0.8B on Beatles Bench

- **Asked:** 2026-10-13. **Where:** Local, a MacBook Pro with an Apple M5 Max chip (18 cores, 128 GB), served by Ollama 0.40.3 as `tev1:0.8b`, asked through ThinkThen's `--backend ollama`. ThinkThen ran on the same machine.
- **Compliance:** `thinkthen backends check --backend ollama --model tev1:0.8b` on 2026-10-13 with ThinkThen 0.2.0 at commit `65ce9d5a`: critical 0, warning 3 (the expected description warnings), all ten functions answered.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 36.8%, Beatles-only 35.7%, hard set 31.3%.
- **Time:** median 0.077 s a request, four calls in flight, 1,501 questions in 40 s. **Tokens:** 275,788 input. **Cost:** $0, local compute.
- **Refusals:** none.
- **Source:** Beatles Bench commit `40e9384c`, knowledge questions only, asked with `scripts/run/thinkthen.sh live` as `./run.sh` asks them. The answers ship with the guide as [bench-0.8b-2026-10-13-answers.jsonl](../models/tev1/results/bench-0.8b-2026-10-13-answers.jsonl), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share) by [bench-summary.py](../models/scripts/bench-summary.py).

Load average 7.79 at the start and 8.51 at the end on 18 cores, with other work on the machine. The bench passed `--backend ollama` to every call through `BENCH_THINKTHEN_ARGS`, so descriptions travelled in Ollama's text form. The bench's runner reads `/proc/loadavg`, which macOS lacks, so this run read the load with Python's `os.getloadavg()` instead; no other line of the bench changed.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.525 |
| forward | 0.208 |
| lead-set | 0.567 |
| lexical-trap | 0.259 |
| lexical-trap-control | 0.269 |
| multi-hop | 0.389 |
| near-neighbor | 0.567 |
| near-neighbor-control | 0.442 |
| none-of-these | 0.275 |
| reversal | 0.415 |
| reversal-general | 0.328 |
| reversal-general-shared-name | 0.845 |
| reverse | 0.317 |
| shared-lead | 0.500 |
| single-hop | 0.315 |

How to use this model with ThinkThen: [its guide](../models/tev1/README.md). Back to [every run](../runs.md).
