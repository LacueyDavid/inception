#!/bin/sh

# Initialiser le répertoire de données si nécessaire
[ ! -d "/var/lib/mysql/mysql" ] && mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

# Démarrer le serveur MariaDB temporaire
mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &

# Attendre que MariaDB soit prêt
for i in $(seq 1 10); do
mariadb -u root -e "SELECT 1" > /dev/null 2>&1 && break
sleep 1
done

# Configurer MariaDB (root, base de données et utilisateur)
mariadb -u root <<-EOSQL
SET @@SESSION.SQL_LOG_BIN=0;
DELETE FROM mysql.user WHERE User='';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

# Arrêter le serveur temporaire
mysqladmin shutdown -u root --password="${MYSQL_ROOT_PASSWORD}"

# Lancer MariaDB normalement
exec "$@"

