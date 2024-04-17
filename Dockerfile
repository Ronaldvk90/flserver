FROM debian:bookworm

# Install the nescesarry packages
RUN dpkg --add-architecture i386
RUN apt update ; apt upgrade -y
RUN apt install xfce4-session xfce4-panel -y
RUN apt install xrdp xterm vim openssh-server wget curl cabextract file dbus-x11 thunar wine32 -y
RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P /usr/bin/
RUN chmod +x /usr/bin/winetricks

# Prepare the files
COPY run.sh /.run.sh
RUN chmod +x /.run.sh

# Finaly. run the server!
ENTRYPOINT /.run.sh