#! /opt/homebrew/bin/fish

set appName (yabai -m query --windows --window | jq .app | tr -d '"') 
set bundleIndentifier (osascript -e 'id of app "'$appName'"')

open -n -b $bundleIndentifier