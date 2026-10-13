#!/bin/sh
# Time one small call of each of the ten functions against nimble on Ollama.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --backend ollama --model nimble "$@"
