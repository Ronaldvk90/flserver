#!/bin/sh

# Prepare a user for the server
adduser -D $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
printf "$PASSWORD\n$PASSWORD\n" | smbpasswd -a $USERNAME

# Start samba
smbd -F
