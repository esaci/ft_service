FROM alpine:3.11.0

RUN apk update && apk add bash nginx openssh openssl && adduser -D -g 'www' www && mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www

COPY src/healthcheck.sh /tmp/. 
COPY src/index.html /var/www/localhost/htdocs/ 
COPY src/nginx.conf /etc/nginx/nginx.conf 
COPY src/sshd_config /etc/ssh/sshd_config 
COPY src/start.sh /tmp/start.sh


RUN addgroup sshgroup && adduser -D user && echo "user:password" | chpasswd

RUN chmod +x /tmp/start.sh
RUN mkdir -p /run/nginx

EXPOSE 80 443 30022

CMD bash /tmp/start.sh