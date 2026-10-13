# Kev-4B

[Kev](https://github.com/jaredpalmer/kev) is a family of open decision models built on Qwen, from 0.8B to 27B, with its own System One server. This guide covers Kev-4B, the size the list has tested.

## Setup

- **Server:** Kev's own server, `kev.serve`, under MLX on Apple Silicon. The tested machine was a MacBook with an M5 chip.
- **Base address:** `http://127.0.0.1:8731/v1`. ThinkThen refuses plain http off localhost, so a remote Kev server is reached through an SSH tunnel to port 8731 on the local machine.
- **Model name:** `kev-latest`, served as Kev-4B.
- **Key:** the tested setup records no key. ThinkThen 0.2 sends no key to a `localhost`, `127.0.0.1` or `[::1]` address when none is set, so a local server needs no placeholder.
- **Wrapper:** none. Kev speaks System One itself.

The exact commands to install Kev and start `kev.serve` with the 4B weights are not yet recorded here; see Kev's own README. Check the backend with:

```
thinkthen backends check --url http://127.0.0.1:8731/v1 --model kev-latest
```

## Compliance check

Passed: critical 0, warning 0, exit 0, on 2026-09-29, with the command above. The one-sided decide question that Liquid d1 first refused passed here. The list does not record which ThinkThen version ran the check.

## Beatles Bench

Asked 2026-09-29: full dataset 47.2%, Beatles-only 44.1%, hard set 39.0%, no refusals. Full report: [Kev-4B on Beatles Bench, 2026-09-29](../../reports/kev-4b-2026-09-29.md).

## Timings

- Beatles Bench, 2026-09-29, local on a MacBook with an M5 chip through an SSH tunnel: median 0.20 s a request, with load between 2.65 and 5.28 on 18 cores.
- Cost on that run: $0, local compute.
- A short timed run of each ThinkThen function: not yet measured.
