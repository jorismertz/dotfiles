#!/usr/bin/env fish

set gapstore (cat /var/tmp/gap_state.tmp)

if [ $gapstore = "disabled" ]
    fish ~/.config/scripts/disablegap.fish
else
    fish ~/.config/scripts/enablegap.fish
end