#!/bin/sh
# Run the ThinkThen compliance check against Jev on TypeSafe's built-in backend.
#   scripts/check.sh          the live check: real requests, real spend
#   scripts/check.sh --plan   the request bodies and request bounds; sends nothing
# The key comes from TYPESAFE_API_KEY; this script never reads it.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend typesafe "$@"
