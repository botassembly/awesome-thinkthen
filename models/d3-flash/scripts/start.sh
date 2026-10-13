#!/bin/sh
# Serve d3-flash through llama.cpp at 127.0.0.1:8080 under the alias `local`, the llamacpp built-in's default model.
# Run models/scripts/install-llamacpp.sh in the same folder first; the vllm d3 models need llama.cpp release b11572 or
# later. Downloads the 6.6 GB Q4_K_M file once. Text only: this setup loads no vision projector.
set -eu
file=vllm-d3-flash-Q4_K_M.gguf
[ -f "$file" ] || curl -fL -o "$file" \
  "https://huggingface.co/ggml-org/vllm-d3-flash-GGUF/resolve/3d53d13778bf8035e6e1e534ce489ed052ee5663/$file"
exec ./llama/llama-server --model "$file" --alias local --host 127.0.0.1 --port 8080 \
  --ctx-size 4096 --batch-size 4096 --ubatch-size 4096 --parallel 1
