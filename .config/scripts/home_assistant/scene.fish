#! /opt/homebrew/bin/fish

set config (cat ~/.config/.sharedsecrets | jq .home_assistant)
set token (echo $config | jq .token | tr -d '"')
set base_url (echo $config | jq .ip | tr -d '"')

curl --silent \
    -H "Authorization: Bearer $token" \
    -H "Content-Type: application/json" \
    -d "{\"entity_id\": \"scene.$argv[1]\" }" \
    "$(echo $base_url)api/services/scene/turn_on" >/dev/null
