#!/bin/sh
# Run the ThinkThen compliance check against tev1 on Ollama.
#   scripts/check.sh [SIZE]   SIZE is 4b (the default) or 0.8b. Add --plan to send nothing.
size=${1:-4b}; [ $# -gt 0 ] && shift
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend ollama --model "tev1:$size" "$@"
