FROM alpine:3.11.0

RUN apk update && apk add bash nginx openssh openssl && adduser -D -g 'www' www && mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www

COPY srcs/healthcheck.sh /tmp/. && srcs/index.html /var/www/localhost/htdocs/ && srcs/nginx.conf /etc/nginx/nginx.conf && srcs/sshd_config /etc/ssh/sshd_config && srcs/start.sh /tmp/start.sh


RUN addgroup sshgroup && adduser -D user && echo "user:password" | chpasswd

RUN chmod +x /tmp/start.sh
RUN mkdir -p /run/nginx

EXPOSE 80 443 30022

CMD bash /tmp/start.sh