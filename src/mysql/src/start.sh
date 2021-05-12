#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
fi

mysql_install_db --user=mysql --datadir=/var/lib/mysql/
nohup /tmp/init_mysql.sh &

exec /usr/bin/mysqld --datadir="/var/lib/mysql/"
