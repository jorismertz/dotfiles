#! /opt/homebrew/bin/fish

yabai -m config          \
        top_padding    0 \
        bottom_padding 0 \
        left_padding   0 \
        right_padding  0 \
        window_gap     0      

echo "disabled" > /var/tmp/gap_state.tmp