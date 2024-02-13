displayQuery=$(yabai -m query --displays)
displayAmount=$(grep -o 'index' <<<"$displayQuery" | grep -c .)

if (( $displayAmount > 1 )); then
    echo 2
else
    echo 1
fi