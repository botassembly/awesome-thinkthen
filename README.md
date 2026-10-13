# Awesome ThinkThen

Models, servers, benchmarks, and papers that work with [ThinkThen](https://github.com/botassembly/thinkthen). ThinkThen turns a decision model's three endpoints into ten typed functions for the shell, libraries, and databases. Each model has a [guide](models/README.md) that shows how to use it with ThinkThen 0.2.

An entry joins this list after the ThinkThen compliance check passes against it, and each entry names the check's result and the date it ran. To add something, [open an issue](CONTRIBUTING.md). Pull requests are not accepted.

## Hosted backends

ThinkThen 0.2.0 ran every check below on 2026-10-13, built from commit `65ce9d5af`.

- [Jev](models/jev/README.md): the decision model ThinkThen was built on, from [TypeSafe](https://docs.typesafe.ai/). Check passed, critical 0, warning 0, 2026-10-13; first recorded 2026-09-23.
- [Liquid d1](models/liquid-d1/README.md): a [decision foundation model](https://docs.liquid.ai/lfm/models/decision-models) from an MIT spin-off, at `api.liquid.ai`. Check passed, critical 0, warning 0, 2026-10-13. The free model rate-limits hard; its guide says how to run it.
- [pplx-decider](models/pplx-decider/README.md): [Perplexity's decision model](https://docs.perplexity.ai/docs/decisions/quickstart), `pplx-decider-v1-27b`. Check passed, critical 0, warning 0, 2026-10-13.
- [Jev through OpenRouter](models/jev-openrouter/README.md): Jev resold by [OpenRouter](https://openrouter.ai/) as `typesafe/jev-1.13`. Check passed, critical 0, warning 0, 2026-10-13.

## Models you run yourself

ThinkThen 0.2.0 ran every check below on 2026-10-13, built from commit `65ce9d5af`, on a MacBook Pro with an Apple M5 Max chip and 128 GB of memory. Each guide holds the exact install, start and check commands.

- [d3-flash](models/d3-flash/README.md): the 9B model of [Decision 3.0](https://huggingface.co/vllm-sr/d3-flash), the open decision models of vLLM Semantic Router, served by llama.cpp. Check passed, critical 0, warning 0, 2026-10-13.
- [Clef-Flash](models/clef-flash/README.md): [Cloudflare's 9B decision model](https://huggingface.co/Cloudflare/clef-flash) with Apache 2.0 weights, served by llama.cpp. Check passed, critical 0, warning 0, 2026-10-13.
- [nimble](models/nimble/README.md): [Bespoke Labs' 9B decision model](https://ollama.com/library/nimble), served by Ollama. Check passed, critical 0, warning 3, 2026-10-13; the warnings mark ThinkThen's text form for Ollama's descriptions.
- [Kev-4B](models/kev-4b/README.md): the 4B size of [Kev](https://github.com/jaredpalmer/kev), Qwen-based decision models from 0.8B to 27B with their own server; llama.cpp serves it too. Check passed on both servers, critical 0, warning 0, 2026-10-13; first recorded 2026-09-29.
- [tev1](models/tev1/README.md): [Together AI's experimental decision models](https://ollama.com/library/tev1) in 4B and 0.8B, served by Ollama. Check passed for both sizes, critical 0, warning 3, 2026-10-13.
- [Strands Decider 2B](models/strands-decider/README.md): [Strands Labs' decision server](https://github.com/strands-labs/strands-decider) under MLX, the target of ThinkThen's `mlx` built-in. Check passed, critical 0, warning 3, 2026-10-13; the warnings mark the built-in's text form for descriptions.
- [Laya](models/laya/README.md): [ModernBERT-large under MLX](https://github.com/mizorewww/laya-mlx), about 421M parameters ([weights](https://huggingface.co/aac6fef/laya-mlx)). Served on System One by [stuntdouble's sidecar](https://github.com/ReallyArtificial/stuntdouble#sidecars), `sidecars/laya.py`. Check passed through that wrapper, critical 0, warning 0, 2026-10-13; first recorded 2026-09-30.

## Tested, not yet working

- [gpt-6-luna](models/gpt-6-luna/README.md), OpenAI's Decisions API: ThinkThen 0.2 speaks its shape, but the check of 2026-10-13 failed with critical 14 because the test account had no credit. Nothing about the model has been measured yet.
- `typesafe/jev-router` on OpenRouter: a chat-completions router, not a decision model. OpenRouter's System One endpoint answers that it does not exist, and the check of 2026-10-13 failed with critical 14. Its notes sit in [the OpenRouter guide](models/jev-openrouter/README.md#typesafejev-router-does-not-work-with-thinkthen).

## Benchmarks

- [Beatles Bench](https://github.com/botassembly/beatles-bench): knowledge judgments over Beatles songs, run through ThinkThen. The leaderboard below scores every backend we test on it.
- [JevBench, by Benchmark Heaven](https://www.benchmarkheaven.com/jev-models/v1.5.4): the typed-decision board. 106 systems as of 2026-09-30, scored on a composite of intelligence, calibration, speed, and cost. [Harness](https://github.com/fstandhartinger/jevbench).
- [JevBench.dev](https://jevbench.dev/): a different project that shares the name and says so itself; it ranks models by verified game wins in StarCraft II and Minecraft. The two boards are unaffiliated, and neither's scores convert to the other's.

A model earns an entry here by being tested, not by being ranked, so the open-model half of the Benchmark Heaven board is not copied into this list.

## Leaderboard

Every system we have run on Beatles Bench, best first among decision models. The large language model sits below the line as the yardstick, with reasoning off. Full reports: [runs.md](runs.md).

| # | System | Where | Full dataset, 1,501 | Hard set, 505 | Report |
| --- | --- | --- | --- | --- | --- |
| 1 | [Jev through OpenRouter](models/jev-openrouter/README.md) | hosted | 70.6% | 56.2% | [2026-10-13](reports/jev-openrouter-2026-10-13.md) |
| 2 | [Jev](models/jev/README.md) | hosted | 69.8% | 55.7% | [2026-10-13](reports/jev-2026-10-13.md) |
| 3 | [Liquid d1](models/liquid-d1/README.md) | hosted | 69.3% | 56.8% | [2026-10-13](reports/liquid-d1-2026-10-13.md) |
| 4 | [pplx-decider](models/pplx-decider/README.md) | hosted | 65.4% | 54.1% | [2026-10-13](reports/pplx-decider-2026-10-13.md) |
| 5 | [d3-flash](models/d3-flash/README.md) | local | 60.6% | 49.1% | [2026-10-13](reports/d3-flash-2026-10-13.md) |
| 6 | [Clef-Flash](models/clef-flash/README.md) | local | 53.4% | 43.4% | [2026-10-13](reports/clef-flash-2026-10-13.md) |
| 7 | [nimble](models/nimble/README.md) | local | 52.6% | 43.5% | [2026-10-13](reports/nimble-2026-10-13.md) |
| 8 | [Kev-4B](models/kev-4b/README.md) | local | 47.9% | 39.8% | [2026-10-13](reports/kev-4b-2026-10-13.md) |
| 9 | [tev1 4B](models/tev1/README.md) | local | 43.6% | 33.7% | [2026-10-13](reports/tev1-4b-2026-10-13.md) |
| 10 | [Strands Decider 2B](models/strands-decider/README.md) | local | 36.8% | 32.1% | [2026-10-13](reports/strands-decider-2026-10-13.md) |
| 11 | [tev1 0.8B](models/tev1/README.md) | local | 36.8% | 31.3% | [2026-10-13](reports/tev1-0.8b-2026-10-13.md) |
| 12 | [Laya](models/laya/README.md) | local | 34.1% | 28.5% | [2026-10-13](reports/laya-2026-10-13.md) |
| — | GLM-5.3 Flash, reasoning off | hosted | 96.7% | 95.4% | [2026-09-23](reports/glm-5.3-flash-2026-09-23.md) |

The hard set is the 505 questions from the seven categories where Jev scores worst. Each row is its newest run, under ThinkThen 0.2. Local rows ran on the M5 Max with ThinkThen on the same machine; Strands Decider 2B and tev1 0.8B tie on the full dataset and sit in hard-set order. The top three differ by less than their 95% intervals, about 2.3 points either way on the full dataset, so the order among them is not settled.

## Papers and articles

The catalog is [papers.md](papers.md), and the papers themselves sit in [papers/](papers/) as Markdown, fetched from arXiv with [markxiv](https://www.markxiv.org/).

## APIs

The decision APIs this list tracks live in [apis/](apis/README.md), one file each:

- [System One](apis/system1.md): TypeSafe's decision API, the shape Jev, Liquid d1, Kev, and Ollama's decision models speak. Supported today, with the published schema and the dialects each backend speaks.
- [Decisions API](apis/decisions-api.md): OpenAI's announced decision API. Waiting on OpenAI's documentation.
