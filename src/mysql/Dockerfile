FROM alpine:3.11.0

RUN apk update && apk add mariadb mariadb-client

COPY src/start.sh /tmp/start.sh
COPY src/my.cnf /etc/my.cnf
COPY src/init_mysql.sh /tmp/init_mysql.sh

EXPOSE 3306

CMD /tmp/start.sh
