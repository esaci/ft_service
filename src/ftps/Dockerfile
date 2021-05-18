FROM alpine:3.11.0

RUN apk update && apk add openssl vsftpd gettext 

ENV IP_TO_SUBST=192.168.49.2

COPY ./srcs/vsftpd.conf /tmp/vsftpd.conf

COPY ./srcs/test.txt /home/user/test.txt

EXPOSE 20 21 30020

COPY srcs/start.sh /usr/sbin

CMD start.sh
