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