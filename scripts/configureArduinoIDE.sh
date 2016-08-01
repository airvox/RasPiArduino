#!/bin/bash

CURRENT_DIRECTORY_CONTENTS="$(ls)"

REQFILE1="tools"
REQFILE2="hardware"
REQFILE3="libraries"
REQFILE4="java"
REQFILE5="arduino"


if [[ 
		"$CURRENT_DIRECTORY_CONTENTS" =~ "$REQFILE1" && "$CURRENT_DIRECTORY_CONTENTS" =~ "$REQFILE2" && 
		"$CURRENT_DIRECTORY_CONTENTS" =~ "$REQFILE3" && "$CURRENT_DIRECTORY_CONTENTS" =~ "$REQFILE4" && 
		"$CURRENT_DIRECTORY_CONTENTS" =~ "$REQFILE5" 
	]]; then
    
    	mkdir -p hardware/RaspberryPi/
    	cd hardware/RaspberryPi/
    	git clone https://github.com/yasir1brahim/RasPiArduino.git piduino

else
    echo "Place the configureArduinoIDE.sh file in the Arduino IDE folder."
fi

