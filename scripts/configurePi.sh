sudo su <<HERE

passwd
sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/" /etc/ssh/sshd_config

cat > /boot/cmdline.txt <<EOL
dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 	elevator=deadline fsck.repair=yes rootwait isolcpus=0
EOL

cat > /etc/rc.local <<EOL
#!/bin/sh -e
/usr/local/bin/run-sketch &
EOL

systemctl disable serial-getty@ttyAMA0

cat > /etc/avahi/services/arduino.service <<EOL
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_arduino._tcp</type>
    <port>22</port>
    <txt-record>board=bplus</txt-record>
  </service>
</service-group>
EOL

service avahi-daemon restart

cd /usr/local/bin
wget https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/merge-sketch-with-bootloader.lua
wget https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/run-avrdude
wget https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/run-sketch
wget https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/telnet
cd ..
chmod +x bin/*

ln -s -f /usr/local/bin/run-avrdude /usr/bin/run-avrdude

apt-get update
apt-get install telnet git

apt-get install ntpdate

echo "Configuration complete"

exec /bin/bash

HERE
