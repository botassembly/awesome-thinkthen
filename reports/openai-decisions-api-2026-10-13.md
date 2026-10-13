# OpenAI Decisions API (gpt-6-luna) on Beatles Bench

- **Asked:** 2026-10-13. **Where:** hosted, OpenAI, `api.openai.com/v1/decisions`, through `--backend openai`. Asked from a Beelink mini PC running Linux.
- **Compliance:** `thinkthen backends check --backend openai` passed on 2026-10-13: critical 0, warning 0.
- **Questions:** full dataset 1,501; hard set 505 (the seven categories where Jev scores worst: lexical-trap and its control, multi-hop, none-of-these, reversal, shared-lead, and the year kind of forward).
- **Scores:** full dataset 88.2%, Beatles-only 87.1%, hard set 83.2%.
- **Time:** median 0.26 s a call, 90th percentile 0.42 s, four calls in flight. **Tokens:** 256,082 input; OpenAI reports no output tokens. **Cost:** $0.026, or $0.017 per 1,000 questions, at OpenAI's published $0.10 per million input tokens with free output.
- **Refusals:** 9, each scored as wrong: four lead-singer questions, one album question, two reversal questions and two general reversal questions. [gaps.tsv](../models/openai-decisions-api/results/bench-2026-10-13/gaps.tsv) lists them.
- **Source:** answers, call times and load averages in [the OpenAI Decisions API guide's results](../models/openai-decisions-api/results/bench-2026-10-13/), scored with the bench's own rules (decide at 0.5, choose takes its winner, a tie holding the truth splits its share). ThinkThen 0.2.0 built from commit `ccb2b579f`, Beatles Bench at commit `40e9384c` with one line changed so that a model's refusal records a gap instead of stopping the run.

The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.

The first run of OpenAI's Decisions API. It scores 17.6 points above the next decision model on the full dataset, and 26.4 points above the best other hard-set score. It is the only model on the list that refuses questions. Load average 7.30 to 16.07 on 16 cores from other work on the machine.

## By category

| Category | Share right |
| --- | --- |
| comparison | 0.783 |
| forward | 0.942 |
| lead-set | 0.962 |
| lexical-trap | 0.870 |
| lexical-trap-control | 0.917 |
| multi-hop | 0.750 |
| near-neighbor | 1.000 |
| near-neighbor-control | 1.000 |
| none-of-these | 0.950 |
| reversal | 0.777 |
| reversal-general | 0.959 |
| reversal-general-shared-name | 0.976 |
| reverse | 0.875 |
| shared-lead | 0.781 |
| single-hop | 0.819 |

How to use this model with ThinkThen: [its guide](../models/openai-decisions-api/README.md). Back to [every run](../runs.md).
