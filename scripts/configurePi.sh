sudo su <<HERE

passwd
raspberry
raspberry

echo ""
echo "Changing root login permission"
echo ""

sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/" /etc/ssh/sshd_config

echo ""
echo "Isolating core 1"
echo ""

cat > /boot/cmdline.txt <<EOL
dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 	elevator=deadline fsck.repair=yes rootwait isolcpus=1
EOL

echo ""
echo "Configure program to run on startup"
echo ""

cat > /etc/rc.local <<EOL
#!/bin/sh -e
/usr/local/bin/run-sketch &
EOL

echo ""
echo "Disable serial port"
echo ""

systemctl disable serial-getty@ttyAMA0

echo ""
echo "Configure Avahi service"
echo ""

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

echo ""
echo "Downloading required files"
echo ""

cd /usr/local/bin
wget -O merge-sketch-with-bootloader.lua https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/merge-sketch-with-bootloader.lua
wget -O run-avrdude https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/run-avrdude
wget -O run-sketch https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/run-sketch
wget -O telnet https://raw.githubusercontent.com/yasir1brahim/RasPiArduino/master/tools/arpi_bins/telnet
cd ..

chmod +x bin/*

ln -s -f /usr/local/bin/run-avrdude /usr/bin/run-avrdude

echo ""
echo "Downloading required packages"
echo ""

apt-get update &&
apt-get install -y telnet git ntpdate

echo ""
echo "Configuration complete"
echo ""

reboot
HERE
