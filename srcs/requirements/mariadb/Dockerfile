FROM alpine:3.19

RUN apk update
RUN apk add vim mariadb mariadb-client
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
COPY conf/setup_mysql.sh /usr/local/bin/setup_mysql.sh

COPY conf/my.cnf /etc/my.cnf

RUN chmod +x /usr/local/bin/setup_mysql.sh

EXPOSE 3306
