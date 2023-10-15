# Welcome to my docker Freelancer server!

The goal of this server is basically to bring a ready to run instant flserver in docker for you. Based on xrdp. :)
It's a fluxbox rdp server with all the basic wine tooling automatically installed when running the install script inside X11.

At building it will create a user so it won't run as root.
Thanks to Microsoft's directplay however, i couldn't run it without network "host" mode...

I want to give a big shout-out to Xantios, who helped me with this server! I couldn't done this without him.
Please check his github repo at https://github.com/Xantios :)

# Now! The business end.

**Environment file!** Don't forget about this one ;)
USER_UID=your user id (you can type "echo $UID for the id on your system)
USER_GID=your group id (you can type "echo $GID for the id on your system)
USERNAME=the username you want to give the flserver (I would suggest fluser)
TZ=your timezone. example, "Europe/NewLondon"
PASSWORD=Your verry secret password!
WINEPREFIX=Where the wine files will be installed. Default soots just fine
WINEARCH=The architecture of wine. whether if it's 32 or 64 bit. Again, the default is fine

Edit the environment.env file to your needs.

then you just have to do a "make install" on your docker host, and your RDP server instanse is ready.
Make clean will stop the container. It will just do a "docker compose down".
Make clean-all will *DELETE* the container and home volume.
Make install-debug will do a compose up verbose start

It will also create a volume which is the home directory for the fluser, where the wine files will be installed.
If you don't have make installed, you can just run "docker compose up".

Next the **freelancer folder**! Just place the extracted iso and (if you want to) the Ioncross Freelancer server operator files in the freelancer folder.
Rename Ioncross exefile to **IFSO.exe**

**Note! It will allways install a fluxbox menu entry for IFSO, even if not installed. If you are not planning to use or install it, just ignore the entry**

# Final step Mr. Trent.
connect a rdp client and type the username and password of the docker host container ip.
Open the flusbox menu and it will automaticaly show the installer.
This will install the server. After installing Freelancer, just run the server from the fluxbox menu and happy roaming the universe Trent! :D
