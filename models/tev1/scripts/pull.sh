#!/bin/sh
# Pull both tev1 sizes into the Ollama that start-ollama.sh runs: 4B, about 4.4 GB, and 0.8B, about 0.8 GB.
set -eu
OLLAMA_HOST=127.0.0.1:11434 ./ollama/ollama pull tev1:4b
OLLAMA_HOST=127.0.0.1:11434 ./ollama/ollama pull tev1:0.8b
