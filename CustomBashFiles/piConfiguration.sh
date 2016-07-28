sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/" /etc/ssh/sshd_config

cat > /boot/cmdline.txt <<EOL
dwc_otg.lpm_enable=0 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 	elevator=deadline fsck.repair=yes rootwait isolcpus=0
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

apt-get update
apt-get install telnet git

git clone https://github.com/yasir1brahim/RasPiArduino.git piduino
chmod +x piduino/tools/arpi_bins/*
cp piduino/tools/arpi_bins/* /usr/local/bin
rm -rf piduino

ln -s /usr/local/bin/run-avrdude /usr/bin/run-avrdude
