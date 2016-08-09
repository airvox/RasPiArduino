#!/bin/bash

OS="$(uname -a)"
CURRENT_DIRECTORY_CONTENTS="$(ls)"
if [[
		"$OS" == *"Darwin"*
	]]; then
		if [[
				"$CURRENT_DIRECTORY_CONTENTS" =~ "Arduino.app"
			]]; then
				mkdir -p Arduino.app/Contents/Java/hardware/RaspberryPi/
	    		cd Arduino.app/Contents/Java/hardware/RaspberryPi/
	    		git clone https://github.com/yasir1brahim/RasPiArduino.git piduino
				wget -qO- https://github.com/me-no-dev/RasPiArduino/releases/download/0.0.1/arm-linux-gnueabihf-osx.tar.gz | tar xvz -C piduino/tools
		else
			echo "Kindly place the configureArduinoIDE.sh file in the same folder as Arduino.app"
		fi
else

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
			wget -qO- https://github.com/me-no-dev/RasPiArduino/releases/download/0.0.1/arm-linux-gnueabihf-linux64.tar.gz | tar xvz -C piduino/tools
	else
	    echo "Kindly place the configureArduinoIDE.sh file in the Arduino IDE folder."
	fi
fi

echo "Configuration complete"