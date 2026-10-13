#!/bin/sh
# Install Laya and stuntdouble's System One sidecar into the current folder.
# Needs a Mac with Apple silicon, macOS 14 or later, git and uv (https://docs.astral.sh/uv/).
# The weights, about 0.8 GB, download from Hugging Face on the first start.
set -eu
git clone https://github.com/ReallyArtificial/stuntdouble.git
git -C stuntdouble checkout fb9f08ec37a4fa62f80a8aeceac1cdcbcb02de29
uv venv -p 3.13 laya-venv
VIRTUAL_ENV=$PWD/laya-venv uv pip install laya-mlx==0.4.0
