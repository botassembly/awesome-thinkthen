# Awesome ThinkThen

Models, servers, benchmarks, talks, and articles that work with [ThinkThen](https://github.com/botassembly/thinkthen). ThinkThen turns a decision model's three endpoints into ten typed functions for the shell, libraries, and databases.

An entry joins this list after the ThinkThen compliance check passes against it, and each entry names the check's result and the date it ran. To add something, [open an issue](CONTRIBUTING.md). Pull requests are not accepted; the maintainers make every change, so the list stays free of spam.

## The wire shape we support

ThinkThen speaks System One: one endpoint, `BASE/systemone`, with typed questions (`noul` yes/no, `choice` pick-one, `score` rate-on-a-scale) and calibrated probabilities back. Jev, Liquid d1, and Kev speak it natively. A second decision API from OpenAI has been announced; ThinkThen aims to support it alongside System One.

## Hosted backends

- [Jev](https://docs.typesafe.ai/): the decision model ThinkThen was built on. Check passed, critical 0, warning 0, first recorded 2026-09-23.
- [Liquid d1](https://docs.liquid.ai/lfm/models/decision-models): the first decision foundation model from an MIT spin-off, at `api.liquid.ai`. One critical finding on one-sided decide criteria, under fix in ThinkThen; every other check row passed 2026-09-29.

## Models you run yourself

- [Kev](https://github.com/jaredpalmer/kev): Qwen-based decision models from 0.8B to 27B that speak the System One API and ship their own server. Check passed against Kev-4B on Apple Silicon: critical 0, warning 0, 2026-09-29.
- Laya: a small Jev-like model run locally through a shim that speaks System One for it. No check row; benched through the shim on 2026-09-23.

## Announced

- OpenAI Decisions API: announced at DevDay on 2026-09-29, not released. It takes a row above when it ships.

## Benchmarks

- [Beatles Bench](https://github.com/botassembly/beatles-bench): knowledge judgments over Beatles songs, run through ThinkThen. Our leaderboard below scores every backend we test on it.
- [JevBench](https://www.benchmarkheaven.com/jev-models/v1.4.2.2): the independent leaderboard of decision models, 91 systems as of 2026-09-27. The open-model category lists 62; we do not copy that list here. A model earns an entry on this list by being tested, not by being ranked.
- [jevbench.dev](https://jevbench.dev/): decision models ranked by verified game wins.

## Leaderboard

Every system we have run on Beatles Bench, best first among decision models. The large language model sits below the line as the yardstick, with reasoning off. Full reports: [runs.md](runs.md).

| # | System | Where | Full dataset, 1,501 | Hard set, 505 | Report |
| --- | --- | --- | --- | --- | --- |
| 1 | Jev | hosted | 70.2% | 55.9% | [2026-09-26](reports/jev-2026-09-26.md) |
| 2 | Liquid d1 | hosted | 63.8% | 50.8% | [2026-09-29](reports/liquid-d1-2026-09-29.md) |
| 3 | Kev-4B | local | 47.2% | 39.0% | [2026-09-29](reports/kev-4b-2026-09-29.md) |
| 4 | Laya | local | 35.8% | 29.9% | [2026-09-23](reports/laya-2026-09-23.md) |
| — | GLM-5.3 Flash, reasoning off | hosted | 96.7% | 95.4% | [2026-09-23](reports/glm-5.3-flash-2026-09-23.md) |

The hard set is the 505 questions from the seven categories where Jev scores worst. A private benchmark may join this table later; it will name itself when it does.

## Papers and articles

One page holds the catalog: [papers.md](papers.md). Papers are kept as Markdown, fetched with [markxiv](https://www.markxiv.org/), so the repository works as a downloadable ThinkThen knowledge base.
