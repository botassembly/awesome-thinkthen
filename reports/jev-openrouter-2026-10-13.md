# Jev through OpenRouter (typesafe/jev-1.13) on Beatles Bench

- **Asked:** 2026-10-13. **Where:** hosted, OpenRouter, `openrouter.ai/api/v1`, through `--backend openrouter`. Replies named `typesafe/jev-1.13-20260917`. Asked from a Beelink mini PC running Linux.
- **Compliance:** `thinkthen backends check --backend openrouter` passed on 2026-10-13: critical 0, warning 0.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 70.6%, Beatles-only 67.5%, hard set 56.2%.
- **Time:** median 0.50 s a call, 90th percentile 0.64 s, four calls in flight. **Tokens:** 555,878 input, 69,275 output. **Cost:** $0.022 for the whole day on this key, as OpenRouter's key report showed it; that covers the check and the timed calls too. OpenRouter lists $0.042 per million input tokens with free output.
- **Refusals:** none.
- **Source:** answers, call times and load averages in [the Jev through OpenRouter guide's results](../models/jev-openrouter/results/bench-2026-10-13/), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share). ThinkThen 0.2.0 built from commit `65ce9d5af`, Beatles Bench at commit `40e9384c`.

The same Jev weights as the direct TypeSafe run of the same day ([report](jev-2026-10-13.md)), reached through OpenRouter. The two runs sent the same number of input tokens and differ by 0.8 points on the full dataset, inside either run's 95% interval. OpenRouter added about 0.18 s to the median call. No call failed and ThinkThen made no retry. Load average 2.07 to 3.98 on 16 cores.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.800 |
| forward | 0.672 |
| lead-set | 0.760 |
| lexical-trap | 0.519 |
| lexical-trap-control | 0.667 |
| multi-hop | 0.556 |
| near-neighbor | 0.833 |
| near-neighbor-control | 0.833 |
| none-of-these | 0.550 |
| reversal | 0.569 |
| reversal-general | 0.904 |
| reversal-general-shared-name | 1.000 |
| reverse | 0.719 |
| shared-lead | 0.625 |
| single-hop | 0.702 |

How to use this model with ThinkThen: [its guide](../models/jev-openrouter/README.md). Back to [every run](../runs.md).
