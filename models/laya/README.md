# Laya

[Laya](https://github.com/mizorewww/laya-mlx) is ModernBERT-large under MLX, about 421M parameters ([weights](https://huggingface.co/aac6fef/laya-mlx)). Laya does not speak System One itself, so a wrapper serves it.

## Setup

- **Wrapper:** [stuntdouble's sidecar](https://github.com/ReallyArtificial/stuntdouble#sidecars), `sidecars/laya.py`, serves Laya on System One.
- **Machine:** a MacBook with an M5 chip.
- **Base address:** the Beatles Bench run of 2026-09-23 reached the shim through an SSH tunnel on port 8791. The base address the sidecar serves, with its path, is not yet recorded here.
- **Model name:** not yet recorded here.
- **Key:** ThinkThen 0.2 sends no key to a loopback address when none is set, so a sidecar on your own machine needs no placeholder. Whether the sidecar itself checks a key is not yet recorded here.

The exact commands to install Laya and start the sidecar are not yet recorded here; see stuntdouble's README. Check the backend with:

```
thinkthen backends check --url LAYA_BASE_URL --model LAYA_MODEL
```

`LAYA_BASE_URL` and `LAYA_MODEL` stand for the sidecar's base address and model name. This list has not yet recorded that exact command and its output against ThinkThen 0.2.

## Compliance check

Passed through stuntdouble's sidecar: critical 0, warning 0, on 2026-09-30 ([System One dialects](../../apis/system1.md#dialects-observed)). The list does not record which ThinkThen version ran the check.

The Beatles Bench run of 2026-09-23 came before this check and went through a System One shim, so its report carries no check row. This list does not record whether that shim was stuntdouble's sidecar.

## Beatles Bench

Asked 2026-09-23 through that shim, one call at a time: full dataset 35.8%, Beatles-only 35.0%, hard set 29.9%, no refusals. Full report: [Laya on Beatles Bench, 2026-09-23](../../reports/laya-2026-09-23.md). No Beatles Bench run through stuntdouble's sidecar is recorded yet.

## Timings

- Beatles Bench, 2026-09-23, local on a MacBook with an M5 chip through the shim and an SSH tunnel: median 0.07 s a request.
- Cost on that run: $0, local compute.
- Timings through stuntdouble's sidecar: not yet measured.
- A short timed run of each ThinkThen function: not yet measured.
