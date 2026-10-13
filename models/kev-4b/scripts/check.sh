#!/bin/sh
# Run the ThinkThen compliance check against Kev's own server. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --url http://127.0.0.1:8009/v1 --model kev-latest "$@"
