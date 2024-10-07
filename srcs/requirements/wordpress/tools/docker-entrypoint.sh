#!/bin/sh

# Si wp-config.php n'existe pas, installer WordPress
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    cd /var/www/wordpress

    # Télécharger la dernière version de WordPress
    wp core download --allow-root

    # Vérifier la connexion à MariaDB
    for i in {1..10}; do
        if mysqladmin --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --host=mariadb ping; then
            break
        fi
        sleep 2
    done

    # Créer la config WordPress et installer
    wp config create                        \
        --dbname=${MYSQL_DATABASE}          \
        --dbuser=${MYSQL_USER}              \
        --dbpass=${MYSQL_PASSWORD}          \
        --dbhost=${WP_DB_HOST}              \
        --dbprefix="wp_"                    \
        --skip-check --force --allow-root

    wp core install                         \
        --url=${DOMAIN_NAME}                \
        --title=${WP_TITLE}                 \
        --admin_user=${WP_ADMIN}            \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL}     \
        --skip-email --allow-root

    # Créer un utilisateur
    wp user create ${WP_USER} ${WP_USER_EMAIL}  \
        --role=author                          \
        --user_pass=${WP_USER_PASSWORD}        \
        --allow-root
fi

# Exécuter la commande passée en argument
exec "$@"

