# 0002 — One tested guide per model

Status: COMPLETE.

Reviews: revision 45c8d99, accept

Landed: 9911c06

## Outcome

Every model the list carries gets its own folder with a README, the scripts that ran it and any other materials. The README shows how to use that model with ThinkThen 0.2, locally or hosted, with the date it was tested and the timings found. The top README points to every folder's README. Bugs found in ThinkThen go to the thinkthen PM for 0.3.

Ian, 2026-10-13: a separate initiative on 0.2, run now in parallel with 0.3.

## Evidence

- Starts from: the list's entries for Jev, Liquid d1, Kev-4B and Laya, their compliance check results and Beatles Bench reports; the market table of decision models, which names Microsoft-Decision-1, OpenAI's Decisions API, Perplexity's pplx-decider, Cloudflare's Clef, Inception's Mercury Decide and the local models served by llama.cpp and Ollama.
- Keeps: the rule that an entry joins only after the compliance check passes; dated, sourced numbers; no private names.
- Changes: each entry becomes a folder, such as `models/jev/README.md`, with setup, a `backends check` run, a short timed run of each function, and the scripts that produced them. Models already on the list move first, because their checks already passed. Each new hosted model needs an account and a key; each local model runs on M5.
- Proof: a reader follows a folder's README on a clean machine and gets the same check result. Timings carry the machine or the hosted region and the date.
- Defers: any model whose account Ian has not authorized. ThinkThen 0.2 already has built-in `openai` and `perplexity` backends, so both are in scope once their keys exist.

Ian, 2026-10-13: keep the ranked leaderboard, best first. The root README shows at most ten ranked rows under the 2026-09-29 rule; runs.md holds every run.
