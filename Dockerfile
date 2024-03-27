FROM opensuse/leap:15.6

# Install the nescesarry packages
RUN zypper update -y
RUN zypper --non-interactive in -t pattern xfce
RUN zypper --non-interactive install xrdp xterm vim openssh-server wget curl cabextract xfce4-terminal wine winetricks file which openssh
RUN winetricks --self-update

# Prepare the files
COPY run.sh /.run.sh
RUN chmod +x /.run.sh

# Finaly. run the server!
ENTRYPOINT /.run.sh
