#!/bin/sh

if [ ! -d "/run/php-fpm7" ]; then
	mkdir -p /run/php-fpm7/
fi
chown -R nginx:www-data /run/php-fpm7/

chown -R nginx:www-data /usr/share/webapps/

ln -s /usr/share/webapps/phpmyadmin/ /var/www/phpmyadmin
envsubst '$IP_MYSQL' < /tmp/config.inc.php > /usr/share/webapps/phpmyadmin/config.inc.php


nginx
if [ $? -ne 0 ];
then
	echo "Failed to start nginx: $status"
	exit 1
fi

php-fpm7
if [ $? -ne 0 ];
then
	echo "Failed to start php-fpm7: $status"
	exit 1
fi

while sleep 20;
do
	if ! pgrep "nginx"
	then
		echo "one of the processes has exited"
		exit 1
	fi
	ps aux |grep php-fpm| grep -v grep
	if ! pgrep "php-fpm"
	then
		echo "one of the processes has exited"
		exit 1
	fi
done
