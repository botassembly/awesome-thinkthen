#!/bin/sh
# Time one small call of each of the ten functions against tev1 on Ollama.
#   scripts/functions.sh [SIZE]   SIZE is 4b (the default) or 0.8b.
size=${1:-4b}; [ $# -gt 0 ] && shift
exec "$(dirname -- "$0")/../../scripts/functions.sh" --backend ollama --model "tev1:$size" "$@"
