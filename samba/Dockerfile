FROM alpine:3.21
RUN apk update && apk upgrade
RUN apk -U add samba
#RUN adduser -D bakruis
COPY smb.conf /etc/samba/smb.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
#ENTRYPOINT [ "/usr/sbin/smbd", "-d=5", "-F" ]
ENTRYPOINT [ "/entrypoint.sh" ]
