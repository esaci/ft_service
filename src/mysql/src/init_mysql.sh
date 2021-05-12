#!/bin/sh

cat <<EOF > conf
RENAME USER 'mysql'@'localhost' to 'user'@'localhost';
SET PASSWORD FOR 'user'@'localhost'=PASSWORD('password') ;
GRANT ALL ON *.* TO 'user'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;

CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL ON wordpress.* TO 'user'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
DROP DATABASE test;
FLUSH PRIVILEGES;
EOF

until mysql
do
	sleep 0.5
done

mysql < conf
