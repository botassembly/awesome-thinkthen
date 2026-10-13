#!/bin/sh
# Time one small call of each of the ten functions against the Laya sidecar.
exec "$(dirname -- "$0")/../../scripts/functions.sh" --url http://127.0.0.1:8011/v1 --model laya-mlx "$@"
