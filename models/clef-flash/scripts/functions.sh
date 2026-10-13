#!/bin/sh
# Time one small call of each of the ten functions against Clef-Flash on llama.cpp.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --backend llamacpp "$@"
