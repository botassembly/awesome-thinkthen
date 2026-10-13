#!/bin/sh
# Run the ThinkThen compliance check against nimble on Ollama, the ollama built-in's default model.
# Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend ollama "$@"
