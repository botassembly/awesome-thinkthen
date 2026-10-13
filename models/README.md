# Models

One folder per model the list carries. Each folder's README shows how to reach that model with ThinkThen 0.2, its compliance check result and date, its Beatles Bench result, and the timings recorded so far.

- [Jev](jev/README.md): hosted, TypeSafe.
- [Liquid d1](liquid-d1/README.md): hosted, Liquid AI.
- [pplx-decider](pplx-decider/README.md): hosted, Perplexity.
- [Jev through OpenRouter](jev-openrouter/README.md): hosted, TypeSafe's Jev reached through OpenRouter.
- [OpenAI Decisions API](openai-decisions-api/README.md): hosted, OpenAI, with the model `gpt-6-luna`.
- [d3-flash](d3-flash/README.md): local, Decision 3.0's 9B model, served by llama.cpp.
- [Clef-Flash](clef-flash/README.md): local, Cloudflare's 9B model, served by llama.cpp.
- [nimble](nimble/README.md): local, Bespoke Labs' 9B model, served by Ollama.
- [Kev-4B](kev-4b/README.md): local, served by Kev's own server or by llama.cpp.
- [tev1](tev1/README.md): local, Together AI's 4B and 0.8B models, served by Ollama.
- [Strands Decider 2B](strands-decider/README.md): local, served by its own MLX server.
- [Laya](laya/README.md): local, served through stuntdouble's System One sidecar.

The local guides share the scripts in [scripts/](scripts/): building ThinkThen 0.2 from source, installing llama.cpp and Ollama, timing the ten functions, and scoring a Beatles Bench run.

A line that reads "Not yet measured" or "Not yet recorded" marks a fact the list has not checked yet. A future live run fills it in with its date and its machine or hosted region.

Each guide reports a Beatles Bench score where one was run. The bench's main score measures what a model remembers about Beatles songs, a trivia test, not how well it decides questions about text you hand it, so treat it as one data point, not a ranking of decision quality.
