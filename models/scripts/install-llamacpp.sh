#!/bin/sh
# Download the llama.cpp release the local guides tested, for a Mac with Apple silicon, into ./llama.
#   models/scripts/install-llamacpp.sh
# Release b11588 (commit 7f51953d7, 2026-10-13) serves POST /v1/systemone and the decision models these guides name.
# Releases before the System One merge of 2026-10-02 answer nothing on that route, and the vllm d3 models need
# release b11572 or later. Other machines take the matching archive from the same release page.
set -eu
tag=b11588
mkdir -p llama
curl -fL -o llama.tar.gz "https://github.com/ggml-org/llama.cpp/releases/download/$tag/llama-$tag-bin-macos-arm64.tar.gz"
tar -xzf llama.tar.gz -C llama --strip-components 1
rm llama.tar.gz
./llama/llama-server --version
