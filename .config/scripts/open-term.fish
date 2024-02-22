#! /opt/homebrew/bin/fish
set currentWindowName (yabai -m query --windows --window | jq -r '.app')

if [ $currentWindowName = "wezterm" ]
    open -n -a wezterm
else
    open -a wezterm
end
