#! /opt/homebrew/bin/fish

# set found_wallpaper_path (osascript -e 'tell app "finder" to get posix path of (get desktop picture as alias)')
set configured_wallpaper_path (cat ~/.config/wallpaper.conf)

osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$configured_wallpaper_path\""
