#!/bin/sh
# Run the ThinkThen compliance check against d3-flash on llama.cpp. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend llamacpp --timeout 120 "$@"
