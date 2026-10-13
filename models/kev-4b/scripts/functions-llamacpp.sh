#!/bin/sh
# Time one small call of each of the ten functions against Kev-4B on llama.cpp.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --backend llamacpp "$@"
