#!/bin/sh
# Send one System One request for typesafe/jev-router to OpenRouter with curl and print the reply and its status.
# ThinkThen does not print a provider's error text, so this shows why OpenRouter refused. The key comes from OPENROUTER_API_KEY.
curl -s -w '\nstatus %{http_code}\n' https://openrouter.ai/api/v1/systemone -H "Authorization: Bearer $OPENROUTER_API_KEY" -H 'Content-Type: application/json' -d '{"state":"The parcel arrived on Tuesday and the box was intact.","model":"typesafe/jev-router","questions":{"q1":{"type":"noul","instructions":"Did the parcel arrive undamaged?"}}}'
