FROM alpine:3.11.0

ENV IP_MYSQL=192.168.49.2

RUN apk update \
	&& apk add nginx php7 php7-fpm  php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php7-bz2 php-zip gettext\ && wget --output-document=/tmp/phpmyadmin.tar.gz http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && mkdir -p /run/nginx && mkdir -p /usr/share/webapps/phpmyadmin/tmp && tar zxvf /tmp/phpmyadmin.tar.gz --strip-components=1 -C /usr/share/webapps/phpmyadmin/

COPY ./src/start.sh /usr/sbin
COPY ./src/phpmyadmin.conf /etc/nginx/conf.d
COPY ./src/config.inc.php /tmp/
COPY ./src/www.conf /etc/php7/php-fpm.d/www.conf

EXPOSE 5000

CMD start.sh
