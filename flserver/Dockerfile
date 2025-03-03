FROM debian:bookworm

# Install the nescesarry packages
RUN dpkg --add-architecture i386
RUN apt update ; apt upgrade -y

RUN apt install -y wget
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
RUN apt update

RUN apt install xfce4-session xfce4-panel xfce4-terminal -y
RUN apt install xrdp xterm vim openssh-server curl cabextract file dbus-x11 thunar -y
RUN apt install -y --install-recommends winehq-stable
RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -P /usr/bin/
RUN chmod +x /usr/bin/winetricks

# Prepare the files
COPY run.sh /.run.sh
RUN chmod +x /.run.sh

# Finaly. run the server!
ENTRYPOINT [ "/.run.sh" ]
