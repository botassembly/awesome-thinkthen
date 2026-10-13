#!/bin/sh
# Run the ThinkThen compliance check against Kev-4B on llama.cpp. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend llamacpp --timeout 120 "$@"
