#!/bin/sh
# Send one OpenAI Decisions request with curl and print the status line, the request ID and the error fields.
# ThinkThen does not print a provider's error text, so this shows why OpenAI refused. The key comes from OPENAI_API_KEY.
curl -s -D - -o /dev/stdout https://api.openai.com/v1/decisions -H "Authorization: Bearer $OPENAI_API_KEY" -H 'Content-Type: application/json' -d '{"model":"gpt-6-luna","input":"The parcel arrived on Tuesday and the box was intact.","questions":[{"name":"q1","type":"predicate","instructions":"Did the parcel arrive undamaged?"}]}' | grep -i -E '^(HTTP|x-ratelimit|retry-after|x-request-id)|"(message|type|code)"'
