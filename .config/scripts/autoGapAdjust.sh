displayQuery=$(yabai -m query --displays)
displayAmount=$(grep -o 'index' <<<"$displayQuery" | grep -c .)

if (( $displayAmount > 1 )); then
    ~/.config/scripts/enablegap.fish
else
    ~/.config/scripts/disablegap.fish
fi