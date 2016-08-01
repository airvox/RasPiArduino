#!/bin/bash

LASTFOLDER=${PWD##*/}
REQUIREDFOLDER="arduino-1.6.9"

if [ $LASTFOLDER == $REQUIREDFOLDER ]; then

    mkdir -p hardware/RaspberryPi/
    cd hardware/RaspberryPi/
    git clone https://github.com/yasir1brahim/RasPiArduino.git piduino

else
	echo Place the configureArduinoIDE.sh file in the Arduino-1.6.9 folder
fi



