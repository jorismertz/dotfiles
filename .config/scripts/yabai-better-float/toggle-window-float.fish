#! /opt/homebrew/bin/fish

# Vertical moves happen before horizontal moves, this needs to be fixed
# The calculation of how much moves need to happen seems to be off sometimes

set windowInfo $(yabai -m query --windows --window)
set isFloating $(echo $windowInfo | jq '.["is-floating"]')
set windowId $(echo $windowInfo | jq '.id')
set tmpFile /tmp/yabai-window-restore-$windowId.tmp

set childTypes "first_child" "second_child" "third_child" "fourth_child"

function parsechildindex
    set windowChildType $(echo $argv[1] | tr -d '"')
    set movesAmount $(contains -i $windowChildType $childTypes )
    set -e moves
end

if [ $isFloating = "false" ]
    # Write current floating window position to temp file
    fish ~/.config/scripts/yabai-better-float/store-window-information.fish
    # Float window and resize to centered 8x10 grid
    yabai -m window --toggle float && yabai -m window --grid 8:10:1:1:8:6
else
    # Parse stored data for focused window
    set storedWindowInfo $(bat $tmpFile)
    set x $(echo $storedWindowInfo | jq '.frame.x')
    set w $(echo $storedWindowInfo | jq '.frame.w')
    set storedChildIndex $(echo $storedWindowInfo | jq '.["split-child"]')
    set storedChildSplitType $(echo $(echo $storedWindowInfo | jq '.["split-type"]')  | tr -d '"')

    # Get display resolution
    set displayResolution $(yabai -m query --displays)
    set displayWidth $(echo $displayResolution | jq '.[0].frame.w')
    set displayHeight $(echo $displayResolution | jq '.[0].frame.h')
    # Unfloat window
    yabai -m window --toggle float
    # Get managed window new position
    set currentX $(yabai -m query --windows --window | jq .frame.x)
    
    # This should also be calculated based on middle point of window
    # Doesn't cause any problems for now though so it's fineeeee
    if [ $currentX -lt $(math $displayWidth / 2) ]
        set newPos "left"
    else
        set newPos "right"
    end
 
    set windowMiddlePoint $(math $x + $w / 2)
    set currentChildIndex $(parsechildindex $(yabai -m query --windows --window | jq '.["split-child"]'))
    set savedChildIndex $(parsechildindex $storedChildIndex)
    
    if [ $savedChildIndex -lt $currentChildIndex ]
        for i in (seq 1 $(math $savedChildIndex - 1))
            if [ $storedChildSplitType = "horizontal" ]
                yabai -m window --warp north
            else
                yabai -m window --warp east
            end
        end
    end
    
    if [ $windowMiddlePoint -lt $(math $displayWidth / 2) ]
        if [ $newPos = "right" ]
            yabai -m window --warp west
        else
        end
    
    else
        if [ $newPos = "left" ]
            yabai -m window --warp east
        end
    end

    # Delete tmp file
    rm $tmpFile
end