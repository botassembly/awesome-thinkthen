#!/bin/sh
# Run the ThinkThen compliance check against Clef-Flash on llama.cpp. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend llamacpp --timeout 120 "$@"
