#!/bin/bash

if [ -d "/home/$USERNAME" ]; then

# Set your timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

# Continue without parts of the user creation
echo "Not the first time the container runs. Skipping parts of the user creation"
useradd --uid $USER_UID -M $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chsh -s /bin/bash $USERNAME

# Make sure DBUS and xrdp-sesman run
if [ -f "/run/dbus/pid" ]; then
    rm /run/dbus/pid
fi

if [ ! -d "/run/dbus" ]; then
  mkdir -p /run/dbus
fi

dbus-daemon --system

if [ -f "/var/run/xrdp-sesman.pid" ]; then
    rm /var/run/xrdp-sesman.pid
fi

rm /etc/xrdp/startwm.sh
cat >> /etc/xrdp/startwm.sh <<EOF
#!/bin/sh
startxfce4
EOF
chmod +x /etc/xrdp/startwm.sh

xrdp-sesman
xrdp --nodaemon

else


### First run script! ###
echo "First time the container is run. Arrange some stuff for you."

# Set your timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

# Prepare a user for the server
useradd --uid $USER_UID -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chsh -s /bin/bash $USERNAME

# Prepare the first run of FLserver
cat <<EOF2 >> /home/$USERNAME/firstrun.sh
#!/bin/bash

# First Create a wine32 prefix.
export WINEARCH=win32

# Set the Windows version needed.
winetricks -q winxp

# Next Install the necessities.
winetricks -q vb6run
winetricks -q directplay
winetricks -q riched30

# Freelancer itself.
wine /freelancer/SETUP.EXE

# Ioncross (if present)
if [ -f "/freelancer/IFSO.exe" ]
then
wine /freelancer/IFSO.exe
else
echo -e "\033[0;33mIoncross FLserver Operator not found. You can install it later if you want to. :)\033[0m"
fi
EOF2

# Make sure DBUS and xrdp-sesman run
if [ -f "/run/dbus/pid" ]; then
rm /run/dbus/pid
fi

if [ ! -d "/run/dbus" ]; then
mkdir -p /run/dbus
fi

dbus-daemon --system

if [ -f "/var/run/xrdp-sesman.pid" ]; then
rm /var/run/xrdp-sesman.pid
fi

rm /etc/xrdp/startwm.sh
cat >> /etc/xrdp/startwm.sh <<EOF3
#!/bin/sh
startxfce4
EOF3
chmod +x /etc/xrdp/startwm.sh


cat >> /usr/share/applications/Firstrun.desktop <<EOF4
[Desktop Entry]
Version=1.0
Type=Application
Name=Firstrun
Comment=Install the Freelancer server
Exec=/home/$USERNAME/firstrun.sh
Icon=applications-games
Path=
Terminal=true
StartupNotify=false
EOF4

chmod +x /home/$USERNAME/firstrun.sh
chmod +x /usr/share/applications/Firstrun.desktop

xrdp-sesman
xrdp --nodaemon
fi