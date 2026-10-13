#!/bin/sh
# Install the Strands decision server with its MLX extra into the current folder, at the source ThinkThen pins.
# Needs a Mac with Apple silicon, git and uv (https://docs.astral.sh/uv/).
set -eu
git clone https://github.com/strands-labs/strands-decider.git
git -C strands-decider checkout 75c9fd32e664954cdc18481434018aa507eee8fb
uv venv -p 3.13 strands-env
VIRTUAL_ENV=$PWD/strands-env uv pip install './strands-decider[mlx]'
