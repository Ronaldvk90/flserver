#!/bin/bash

if [ -d "/home/$USERNAME" ]; then

# Set your timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

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

# Prepare a user for the server
useradd --uid $USER_UID -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chsh -s /bin/bash $USERNAME

# Set the environment world wide (thanks Xantios)
cat >>  /home/$USERNAME/.bashrc <<EOF2
export USER_UID="$USER_UID"
export USERNAME="$USERNAME"
EOF2

# Prepare the first run of FLserver
cat <<EOF3 >> /home/$USERNAME/firstrun.sh
#!/bin/bash

# First Create a wine32 prefix.
wine wineboot

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
EOF3

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
cat >> /etc/xrdp/startwm.sh <<EOF4
#!/bin/sh
startxfce4
EOF4
chmod +x /etc/xrdp/startwm.sh

mkdir /home/$USERNAME/Desktop
cat >> /home/$USERNAME/Desktop/Firstrun.desktop <<EOF5
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
EOF5

chown $USERNAME:users /home/$USERNAME/Desktop
chown $USERNAME:users /home/$USERNAME/Desktop/Firstrun.desktop
chown $USERNAME:users /home/$USERNAME/firstrun.sh
chmod +x /home/$USERNAME/firstrun.sh
chmod +x /home/$USERNAME/Desktop/Firstrun.desktop

xrdp-sesman
xrdp --nodaemon
fi