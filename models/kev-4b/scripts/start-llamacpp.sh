#!/bin/sh
# Serve Kev-4B through llama.cpp at 127.0.0.1:8080 under the alias `local`, the llamacpp built-in's default model.
# Run models/scripts/install-llamacpp.sh in the same folder first. Downloads the 3.0 GB Q4_K_M file once.
set -eu
file=Kev-4B-Q4_K_M.gguf
[ -f "$file" ] || curl -fL -o "$file" \
  "https://huggingface.co/ggml-org/Kev-4B-GGUF/resolve/d924f2e2c3872da8b8aaf3eb4453b4126deceb79/$file"
exec ./llama/llama-server --model "$file" --alias local --host 127.0.0.1 --port 8080 \
  --ctx-size 4096 --batch-size 4096 --ubatch-size 4096 --parallel 1
