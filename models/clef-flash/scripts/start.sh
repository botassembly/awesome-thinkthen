#!/bin/sh
# Serve Clef-Flash through llama.cpp at 127.0.0.1:8080 under the alias `local`, the llamacpp built-in's default model.
# Run models/scripts/install-llamacpp.sh in the same folder first. Downloads the 6.5 GB Q4_K_M file once, at the
# revision ThinkThen's own local setup page pins.
set -eu
file=Clef-Flash-Q4_K_M.gguf
[ -f "$file" ] || curl -fL -o "$file" \
  "https://huggingface.co/ggml-org/Clef-Flash-GGUF/resolve/4a7a08c09bc63baf043b62b5ba89dd67a0357d95/$file"
exec ./llama/llama-server --model "$file" --alias local --host 127.0.0.1 --port 8080 \
  --ctx-size 4096 --batch-size 4096 --ubatch-size 4096 --parallel 1
