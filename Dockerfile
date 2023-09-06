FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

# Install the nescesarry packages
RUN dpkg --add-architecture i386
RUN apt update -y ; apt upgrade -y ; apt install -y xrdp fluxbox xterm vim openssh-server wget curl cabextract tzdata
RUN mkdir -pm755 /etc/apt/keyrings
RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
RUN apt update ; apt upgrade -y ; apt install -y --install-recommends winehq-stable
RUN wget -O /bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /bin/winetricks

# Prepare the files
COPY run.sh /.run.sh
RUN chmod +x /.run.sh

# Finaly. run the server!
#ENTRYPOINT [ "/.run.sh" ]
ENTRYPOINT /.run.sh
