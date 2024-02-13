#! /opt/homebrew/bin/fish

killall Finder
killall Dock
yabai --restart-service
brew services restart sketchybar
~/.config/scripts/verifyWallpaper.fish
