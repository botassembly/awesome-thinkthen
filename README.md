# Awesome ThinkThen

Models, servers, benchmarks, and papers that work with [ThinkThen](https://github.com/botassembly/thinkthen). ThinkThen turns a decision model's three endpoints into ten typed functions for the shell, libraries, and databases.

An entry joins this list after the ThinkThen compliance check passes against it, and each entry names the check's result and the date it ran. To add something, [open an issue](CONTRIBUTING.md). Pull requests are not accepted.

## Hosted backends

- [Jev](https://docs.typesafe.ai/): the decision model ThinkThen was built on. Check passed, critical 0, warning 0, first recorded 2026-09-23.
- [Liquid d1](https://docs.liquid.ai/lfm/models/decision-models): a decision foundation model from an MIT spin-off, at `api.liquid.ai`. Every check row passed 2026-09-29 except one critical: it refuses a one-sided decide criteria question. The fix sits in ThinkThen.

## Models you run yourself

- [Kev](https://github.com/jaredpalmer/kev): Qwen-based decision models from 0.8B to 27B, with their own server. Check passed against Kev-4B on Apple Silicon: critical 0, warning 0, 2026-09-29.
- [Laya](https://github.com/aac6fef/laya-mlx): ModernBERT-large under MLX, about 421M parameters. It does not speak System One itself; a small shim serves it on that API. Benched through the shim on 2026-09-23. No check row.

## Announced

- OpenAI Decisions API: announced at DevDay on 2026-09-29, not released. It takes a row above when it ships.

## Benchmarks

- [Beatles Bench](https://github.com/botassembly/beatles-bench): knowledge judgments over Beatles songs, run through ThinkThen. The leaderboard below scores every backend we test on it.
- [JevBench, by Benchmark Heaven](https://www.benchmarkheaven.com/jev-models/v1.5.4): the typed-decision board. 106 systems as of 2026-09-29, scored on a composite of intelligence, calibration, speed, and cost. [Harness](https://github.com/fstandhartinger/jevbench).
- [JevBench.dev](https://jevbench.dev/): a different project that shares the name and says so itself; it ranks models by verified game wins in StarCraft II and Minecraft. The two boards are unaffiliated, and neither's scores convert to the other's.

A model earns an entry here by being tested, not by being ranked, so the open-model half of the Benchmark Heaven board is not copied into this list.

## Leaderboard

Every system we have run on Beatles Bench, best first among decision models. The large language model sits below the line as the yardstick, with reasoning off. Full reports: [runs.md](runs.md).

| # | System | Where | Full dataset, 1,501 | Hard set, 505 | Report |
| --- | --- | --- | --- | --- | --- |
| 1 | Jev | hosted | 70.2% | 55.9% | [2026-09-26](reports/jev-2026-09-26.md) |
| 2 | Liquid d1 | hosted | 63.8% | 50.8% | [2026-09-29](reports/liquid-d1-2026-09-29.md) |
| 3 | Kev-4B | local | 47.2% | 39.0% | [2026-09-29](reports/kev-4b-2026-09-29.md) |
| 4 | Laya | local | 35.8% | 29.9% | [2026-09-23](reports/laya-2026-09-23.md) |
| — | GLM-5.3 Flash, reasoning off | hosted | 96.7% | 95.4% | [2026-09-23](reports/glm-5.3-flash-2026-09-23.md) |

The hard set is the 505 questions from the seven categories where Jev scores worst.

## Papers and articles

The catalog is [papers.md](papers.md), and the papers themselves sit in [papers/](papers/) as Markdown, fetched from arXiv with [markxiv](https://www.markxiv.org/).

## APIs

The decision APIs this list tracks live in [apis/](apis/README.md), one file each:

- [System One](apis/system1.md): TypeSafe's decision API, the shape Jev, Liquid d1, Kev, and Ollama's decision models speak. Supported today, with the published schema and the dialects each backend speaks.
- [Decisions API](apis/decisions-api.md): OpenAI's announced decision API. Waiting on OpenAI's documentation.
