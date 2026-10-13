#!/bin/sh
# Time one small call of each of the ten functions against Kev's own server.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --url http://127.0.0.1:8009/v1 --model kev-latest "$@"
