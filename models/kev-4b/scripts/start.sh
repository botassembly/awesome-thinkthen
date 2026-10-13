#!/bin/sh
# Start Kev-4B on Kev's own server at 127.0.0.1:8009, from the folder install.sh ran in.
# The first start downloads the Kev-4B checkpoint and its Qwen3.5-4B base from Hugging Face.
cd kev
exec uv run --extra serve python -m kev.serve --run jaredpalmer/kev-4b --port 8009
