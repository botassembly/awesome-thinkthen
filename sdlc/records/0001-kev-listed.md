# 0001 — Kev listed after its compliance check

Landed 2026-09-29. Experiment 414 (`~/workspace/experiments/414-kev-check-and-bench/RESULTS.md`) reduced the named risk: Kev claimed the System One contract, and the list's entry rule needs a passing ThinkThen compliance check, not a README's word.

## What ran

- Kev-4B served by `kev.serve` on the M5 MacBook (MLX, Apple Silicon), reached through an SSH tunnel because thinkthen refuses plain http off localhost.
- `thinkthen check --url http://127.0.0.1:8731/v1 --model kev-latest`: critical 0, warning 0, exit 0. The one-sided decide criteria question that Liquid's d1 refuses passed here, so that incompatibility is Liquid-specific.
- Beatles Bench, all 1,501 questions, no refusals: 44.1% Beatles-only, 47.2% overall, median 0.20 s a request. Between Laya and Jev, as the bench's story predicts for a small model asked to remember fine detail.

## What changed

- README lists Kev under "Models you run yourself" with the check result and its date, per the entry rule.
- `2026-09-24-make-kev-work.md` closed with the experiment named.

## Checks

The listing commit carries both file changes. No benchmark number entered the list; the bench numbers stay in the experiment's RESULTS.md, which names its run folder.
