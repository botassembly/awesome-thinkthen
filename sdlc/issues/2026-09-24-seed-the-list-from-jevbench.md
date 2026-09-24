# Seed the list from JevBench

Status: Open

JevBench v1.2 (scored 2026-09-19, harness at https://github.com/fstandhartinger/jevbench) measures 21 decision systems on 534 decisions. Ian's clipping is `notes/clippings/JevBench.md`. Its open systems are the first candidates for this list:

- SemIf, formerly OpenJev (Qwen3.5-4B): https://github.com/TheoLeeCJ/openjev
- openjev-sglang (Qwen3.6-35B-A3B on SGLang): https://github.com/ekzhang/openjev-sglang
- OpenJev (razorback16): https://github.com/razorback16/openjev
- open-alternative-jev: https://github.com/ikermoel/open-alternative-jev
- openJev Verdict: https://github.com/Heman10x-NGU/openJev-verdict-2.0
- system-one: https://github.com/sgoedecke/system-one
- system-one-open: https://github.com/mithalouni/system-one-open
- typed-decisions (open-jev-deberta-v3-large): https://github.com/kotoba-lang/typed-decisions
- jeff (GLiFormer 400M): https://github.com/logan-markewich/jeff
- Needle 3: https://github.com/cactus-compute/needle
- Bespoke Nimble 9B: https://github.com/bespokelabsai/nimble
- Laya: https://huggingface.co/convaiinnovations/laya
- Hosted: classifier.dev, djev.dev

For each candidate, record whether it serves the Jev wire shape, whether ThinkThen's compliance check passes, and its JevBench score. JevBench itself goes under Benchmarks. Look for other Jev or TypeSafe awesome lists to borrow from.
