# Make Kev work with ThinkThen

Status: Closed 2026-09-29. A local experiment (414) ran the compliance check against a local Kev-4B server on Apple Silicon (critical 0, warning 0) and all 1,501 Beatles Bench questions with no refusals. Kev is listed under Models you run yourself with the check result and date.

Kev (https://github.com/jaredpalmer/kev) is a LoRA adapter and readout head on Qwen3 0.6B, 4B, or 8B. It follows TypeSafe's System One API contract, and the official SDK works against a local Kev server by changing `base_url`. Ian's clipping is in `notes/clippings/`.

Run a local Kev server, point ThinkThen at it, and run the compliance check and Beatles Bench. List it when the check passes. Running it needs a machine with a GPU or Apple Silicon. Pick the machine from the workspace README.
