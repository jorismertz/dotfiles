#!  /opt/homebrew/bin/fish

# Custom values
set airpodsMacAdress 2c-32-6a-d6-b4-b5
set builtInOutput "MacBook Pro Speakers"
set airpods "Djor’s AirPods Pro"

set isConnected $(blueutil --is-connected $airpodsMacAdress)
set isFound $(count (SwitchAudioSource -a | grep $airpods))
set currentDevice $(SwitchAudioSource -c)

set bluetoothIsOn $(blueutil -p)

if [ $bluetoothIsOn = 0 ]
    blueutil -p 1
end

if [ $isConnected = 0 ]
    if [ $isFound = 2 ]
        SwitchAudioSource -s $airpods
    else
        blueutil --connect $airpodsMacAdress
    end
else
    if [ $currentDevice = $airpods ]
        SwitchAudioSource -s $builtInOutput
    else
        SwitchAudioSource -s $airpods
    end
end
