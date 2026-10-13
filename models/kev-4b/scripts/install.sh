#!/bin/sh
# Install Kev's own System One server into ./kev. Needs git and uv (https://docs.astral.sh/uv/).
# On Apple silicon the serve extra installs MLX, and the server uses it for Kev's checkpoints.
set -eu
git clone https://github.com/jaredpalmer/kev.git
cd kev
git checkout 85ccf56a0afb952323c621055b02876e8498d60c
uv sync --extra serve
