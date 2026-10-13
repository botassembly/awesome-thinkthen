#!/bin/sh
# Run the ThinkThen compliance check against the Laya sidecar. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --url http://127.0.0.1:8011/v1 --model laya-mlx "$@"
