#!/bin/sh

mkdir -p /run/nginx
mkdir -p /usr/share/webapps
tar -xzf /tmp/latest.tar.gz  -C /usr/share/webapps/
mkdir -m 777 /usr/share/webapps/wordpress/wp-content/uploads
chown -R nginx:www-data /usr/share/webapps/

ln -s /usr/share/webapps/wordpress /var/www/wordpress

cd /usr/share/webapps/wordpress
mv  ./wp-config-sample.php wp-config.php

sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/password_here/password/" wp-config.php
sed -i "s/username_here/user/" wp-config.php
sed -i "s/localhost/${MYSQL_IP}:3306/" wp-config.php

su -s /bin/sh -c "init_wp.sh" nginx

nginx
php-fpm7


while sleep 20;
do
	if ! pgrep "nginx"
	then
		exit 1
	fi
	if ! pgrep "php-fpm"
	then
		exit 1
	fi
done