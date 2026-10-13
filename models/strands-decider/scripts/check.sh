#!/bin/sh
# Run the ThinkThen compliance check against the Strands server. Add --plan to send nothing.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend mlx "$@"
