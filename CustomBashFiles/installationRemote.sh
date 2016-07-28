mkdir -p /hardware/RaspberryPi/
cd hardware/RaspberryPi/
git init
git clone https://github.com/yasir1brahim/RasPiArduino.git piduino
wget -qO- https://github.com/me-no-dev/RasPiArduino/releases/download/0.0.1/arm-linux-gnueabihf-linux64.tar.gz | tar xvz -C piduino/tools
