#!/bin/sh

envsubst '$IP_TO_SUBST' < /tmp/vsftpd.conf > /etc/vsftpd/vsftpd.conf

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=/O=42/CN=cldidier' -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

adduser -D user && echo "user:password" | chpasswd 
echo "user" >/etc/vsftpd.userlist

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log &

usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
