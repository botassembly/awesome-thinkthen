#!/bin/sh
# Start Ollama on 127.0.0.1:11434, the ollama built-in's default address, keeping models in ./ollama-models.
# Run models/scripts/install-ollama.sh in the same folder first. Then pull a model in another terminal, such as
#   OLLAMA_HOST=127.0.0.1:11434 ./ollama/ollama pull nimble
OLLAMA_HOST=127.0.0.1:11434 OLLAMA_MODELS=$PWD/ollama-models exec ./ollama/ollama serve
