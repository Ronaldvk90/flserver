#!/bin/bash

if [ -d "/home/$USERNAME" ]; then

# Set your timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

# Continue without parts of the user creation
echo "Not the first time the container runs. Skipping parts of the user creation"
groupadd --gid $USER_GID $USERNAME
useradd --uid $USER_UID --gid $USER_GID -M $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chsh -s /bin/bash $USERNAME

xrdp-sesman
xrdp --nodaemon

else

echo "First time the container is run. Arrange some stuff for you."

# Set your timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

# Prepare a user for the server
groupadd --gid $USER_GID $USERNAME
useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
chsh -s /bin/bash $USERNAME

# Set the environment world wide (thanks Xantios)
cat >>  /etc/profile <<EOF
export USER_UID="$USER_UID"
export USER_GID="$USER_GID"
export USERNAME="$USERNAME"
export WINEPREFIX="$WINEPREFIX"
export WINEARCH="$WINEARCH"
EOF

mkdir -p /home/$USERNAME/.fluxbox
cat >  /home/$USERNAME/.fluxbox/menu <<EOF2
[begin] (fluxbox)
[include] (/etc/X11/fluxbox/fluxbox-menu)
[include] (/home/$USERNAME/.fluxbox/flmenu)
[end]
EOF2

cat > /home/$USERNAME/.fluxbox/flmenu <<EOF3
[submenu] (Freelancer Server)
        [exec] (Freelancer server Installer) {x-terminal-emulator -T "Bash" -e /firstrun.sh}
[END]
EOF3

chown -R $USERNAME:$USERNAME /home/$USERNAME/.fluxbox

# Prepare the first run of FLserver
cat <<EOF4 >> /firstrun.sh
#!/bin/bash

# First Create a wine32 prefix.
wine wineboot

# Set the Windows version needed.
winetricks winxp

# Next Install the necessities.
winetricks -q vb6run
winetricks -q directplay
winetricks -q riched30

# Freelancer itself.
wine /freelancer/SETUP.EXE

if [ -f "/freelancer/IFSO.exe" ]
then
wine /freelancer/IFSO.exe
else
echo -e "\033[0;33mIoncross FLserver Operator not found. You can install it later if you want to. :)\033[0m"
fi

cat > /home/$USERNAME/.fluxbox/flmenu <<EOF5
[submenu] (Freelancer Server)
        [exec] (Freelancer Server) {sh -c "cd $WINEPREFIX/drive_c/Program\ Files/Microsoft\ Games/Freelancer/EXE; wine $WINEPREFIX/drive_c/Program\ Files/Microsoft\ Games/Freelancer/EXE/flserver.exe"}
        [exec] (IONCross FL Server Operator) {sh -c "cd $WINEPREFIX/drive_c/Program\ Files/IONCROSS\ Freelancer\ Server\ Operator\ mk.V.1; wine $WINEPREFIX/drive_c/Program\ Files/IONCROSS\ Freelancer\ Server\ Operator\ mk.V.1/FLServerOperator.exe"}
[end]
EOF5
EOF4

echo "fluxbox" | tee /home/$USERNAME/.xsession
chown -R $USERNAME:$USERNAME /home/$USERNAME/.xsession
chmod +x /firstrun.sh

xrdp-sesman
xrdp --nodaemon
fi