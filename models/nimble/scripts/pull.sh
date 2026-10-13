#!/bin/sh
# Pull nimble, about 9.3 GB, into the Ollama that start-ollama.sh runs.
OLLAMA_HOST=127.0.0.1:11434 exec ./ollama/ollama pull nimble
