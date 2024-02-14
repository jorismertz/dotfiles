#! /opt/homebrew/bin/fish
set currentWindowName (yabai -m query --windows --window | jq -r '.app')

if [ $currentWindowName = "kitty" ]
    open -n -a kitty
else
    open -a kitty
end
