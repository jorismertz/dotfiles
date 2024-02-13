#! /opt/homebrew/bin/fish

set gapSize 12

yabai -m config                  \
        top_padding    $gapSize  \
        bottom_padding $gapSize  \
        left_padding   $gapSize  \
        right_padding  $gapSize  \
        window_gap     $gapSize        

echo "enabled" > /var/tmp/gap_state.tmp