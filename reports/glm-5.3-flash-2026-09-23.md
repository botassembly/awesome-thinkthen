# GLM-5.3 Flash, reasoning off on Beatles Bench

- **Asked:** 2026-09-23. **Where:** Hosted, Z.ai, through the bench’s chat runner.
- **Compliance:** Not a System One backend. It answers through `scripts/run/chat.py` with thinking off and no search tool, so no compliance check applies.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 96.7%, Beatles-only 96.2%, hard set 95.4%.
- **Time:** median 8.24 s a request. **Tokens:** 516,073 input. **Cost:** $0.0555 per 1,000 questions, at Z.ai pricing.
- **Refusals:** none.
- **Source:** Beatles Bench `results/runs/2026-09-23-glm-5.3-flash`, scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share).

The yardstick, not a competitor: a large language model that has read the pages the answers come from. It gives up about one point from the full dataset to the hard set, where every decision model gives up more.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.983 |
| forward | 0.973 |
| lead-set | 0.923 |
| lexical-trap | 0.926 |
| lexical-trap-control | 0.981 |
| multi-hop | 0.972 |
| near-neighbor | 1.000 |
| near-neighbor-control | 1.000 |
| none-of-these | 0.983 |
| reversal | 0.908 |
| reversal-general | 1.000 |
| reversal-general-shared-name | 1.000 |
| reverse | 0.914 |
| shared-lead | 0.844 |
| single-hop | 0.988 |

Back to [every run](../runs.md).
