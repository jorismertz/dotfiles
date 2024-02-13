#! /opt/homebrew/bin/fish

set loop_amount 90
set file_name "Constellation.mp3"
set duration 300
set new_file_name "output.mp3"

for i in (seq $loop_amount)
      echo "file '$PWD/$file_name'" >> concat.txt 
end

ffmpeg -t $duration -f concat -safe 0 -i concat.txt -c copy -t $duration $new_file_name

rm concat.txt
