#!/bin/sh
# Time one small call of each of the ten functions against the Strands server.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --backend mlx "$@"
