# Welcome to my docker Freelancer server!

The goal of this server is basically to bring a ready to run instant flserver in docker for you. Based on xrdp. :)
It's a xfce rdp server with all the basic wine tooling automatically installed when running the installer in the xfce menu in "other".

At building it will create a user so it won't run as root.
Thanks to Microsoft's directplay however, i couldn't run it without network "host" mode...

I want to give a big shout-out to Xantios, who helped me with this server! I couldn't done this without him.
Please check his github repo at https://github.com/Xantios :)

# Now! The business end.

**Environment file!** Don't forget about this one ;)
USERNAME=the username you want to give the flserver (I would suggest fluser)
PASSWORD=Your verry secret password!

Copy the .env.example to .env.
Edit the env file to your needs.

Then just docker compose up

It will also create a volume which is the home directory for the fluser, where the wine files will be installed.
If you don't have make installed, you can just run "docker compose up".

Next the **freelancer folder**! Just place the extracted iso and (if you want to) the Ioncross Freelancer server operator files in the freelancer folder.
Rename Ioncross exefile to **IFSO.exe**

# Please note!
If you use IFSO, be sure to download the latest **FLAdmin.dll** file from the internet. Put it in the wine system32 directory. Or else starting and stopping the server from IFSO won't work correctly. :)

# Final step Mr. Trent.
connect a rdp client and type the username and password of the docker host container ip.
The installer will be on the desktop.
Just install the server. After installing Freelancer, just run the server from the  menu and happy roaming the universe Trent! :D
