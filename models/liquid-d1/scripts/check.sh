#!/bin/sh
# Run the ThinkThen compliance check against Liquid d1 through ThinkThen's built-in liquid backend.
#   scripts/check.sh          the live check: real requests, real spend
#   scripts/check.sh --plan   the request bodies and request bounds; sends nothing
# The key comes from LIQUIDAI_API_KEY; this script never reads it.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend liquid "$@"
