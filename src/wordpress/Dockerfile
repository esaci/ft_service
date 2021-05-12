FROM alpine:3.11.0

ENV MYSQL_IP=http://192.16.49:3306
ENV	IP_MINIKUBE=192.16.49.2


RUN apk update && apk add nginx php7 php7-bcmath php7-ctype php7-curl php7-fpm php7-gd php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-mysqlnd php7-opcache php7-openssl php7-pdo php7-pdo_mysql php7-mysqli php7-pdo_pgsql php7-pdo_sqlite php7-phar php7-posix php7-session php7-soap php7-xml php7-zip  && wget -P /tmp/ http://wordpress.org/latest.tar.gz && wget -P /tmp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /tmp/wp-cli.phar && mv /tmp/wp-cli.phar /usr/sbin/wp 

COPY /src/start.sh /usr/sbin
COPY ./src/init_wp.sh /usr/sbin
COPY ./src/elias.txt /tmp
COPY ./src/wp.conf /etc/nginx/conf.d

EXPOSE 5050

CMD ["start.sh"]
