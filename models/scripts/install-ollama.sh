#!/bin/sh
# Download the Ollama release the local guides tested, for macOS, into ./ollama. Installs nothing system-wide.
#   models/scripts/install-ollama.sh
# The desktop app from ollama.com works the same way; it serves on the same address.
set -eu
tag=v0.40.3
mkdir -p ollama
curl -fL -o ollama-darwin.tgz "https://github.com/ollama/ollama/releases/download/$tag/ollama-darwin.tgz"
tar -xzf ollama-darwin.tgz -C ollama
rm ollama-darwin.tgz
./ollama/ollama --version || true
