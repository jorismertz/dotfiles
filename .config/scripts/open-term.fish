#! /opt/homebrew/bin/fish
set currentWindowName (yabai -m query --windows --window | jq -r '.app')

if [ $currentWindowName = "alacritty" ]
    open -n -a alacritty
else
    open -a alacritty
end
