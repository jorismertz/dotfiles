set windowQuery $(yabai -m query --windows --window)

set windowFrame $(echo $windowQuery | jq .frame)
set childType $(echo $windowQuery | jq '.["split-child"]')
set splitType $(echo $windowQuery | jq '.["split-type"]')
set windowId $(echo $windowQuery | jq .id)

set jsonBlob "{ \"frame\": $windowFrame, \"split-child\": $childType, \"split-type\": $splitType, \"id\": $windowId }"
echo $jsonBlob > /tmp/yabai-window-restore-$windowId.tmp