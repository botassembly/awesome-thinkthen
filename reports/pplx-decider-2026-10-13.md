# pplx-decider (pplx-decider-v1-27b) on Beatles Bench

- **Asked:** 2026-10-13. **Where:** hosted, Perplexity, `api.perplexity.ai`, through `--backend perplexity`. Asked from a Beelink mini PC running Linux.
- **Compliance:** `thinkthen backends check --backend perplexity` passed on 2026-10-13: critical 0, warning 0.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 65.4%, Beatles-only 62.8%, hard set 54.1%.
- **Time:** median 0.51 s a call, 90th percentile 0.66 s, four calls in flight. **Tokens:** 215,628 input, 1,501 output. **Cost:** $0.0043, or $0.003 per 1,000 questions, at Perplexity's published $0.02 per million input tokens with free output.
- **Refusals:** none.
- **Source:** answers, call times and load averages in [the pplx-decider guide's results](../models/pplx-decider/results/bench-2026-10-13/), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share). ThinkThen 0.2.0 built from commit `65ce9d5af`, Beatles Bench at commit `40e9384c`.

The first Perplexity run. It speaks a System One dialect at `api.perplexity.ai/v1/decisions`. ThinkThen retried 19 times over the run, and every question was answered. Load average 2.07 to 4.38 on 16 cores. No pick-one answer tied at the top.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.700 |
| forward | 0.594 |
| lead-set | 0.837 |
| lexical-trap | 0.667 |
| lexical-trap-control | 0.685 |
| multi-hop | 0.511 |
| near-neighbor | 0.700 |
| near-neighbor-control | 0.750 |
| none-of-these | 0.433 |
| reversal | 0.492 |
| reversal-general | 0.808 |
| reversal-general-shared-name | 0.929 |
| reverse | 0.589 |
| shared-lead | 0.469 |
| single-hop | 0.694 |

How to use this model with ThinkThen: [its guide](../models/pplx-decider/README.md). Back to [every run](../runs.md).
