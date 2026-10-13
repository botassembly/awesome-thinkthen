#!/bin/sh
# Run the ThinkThen compliance check against the OpenAI Decisions API, model gpt-6-luna, through ThinkThen's built-in openai backend.
#   scripts/check.sh          the live check: real requests, real spend
#   scripts/check.sh --plan   the request bodies and request bounds; sends nothing
# The key comes from OPENAI_API_KEY; this script never reads it.
exec "${THINKTHEN_BIN:-thinkthen}" backends check --backend openai "$@"
