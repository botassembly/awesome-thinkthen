# Serve any model as a Jev backend

Status: Open. Research question.

Ian, 2026-09-24: are there systems that run arbitrary models as Jev-compliant APIs, or should we build a ThinkThen server?

What the clippings already show:
- Kev ships its own System One server.
- openjev-sglang serves a Qwen model on SGLang behind the Jev shape.
- SemIf (formerly OpenJev) scores Qwen3.5-4B with Torch and MLX backends. Its clipping shows a scoring command and no server. Check whether it has one.
- system-one and system-one-open look like general servers. Read them.

Answer: which projects serve any Hugging Face model behind the Jev shape, which models each supports, and what is missing. Recommend using one, contributing to one, or building a ThinkThen server. Building one is a ThinkThen architect decision. The ThinkThen ideal state says "A local or open model is reached by a small server presenting the same shape."
