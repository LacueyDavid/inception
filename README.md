# School project with docker, nginx, mariadb and wordpress

## Exemple de .env:

- MYSQL_DATABASE=mysql_inception_database
- MYSQL_USER=mysql_user
- MYSQL_PASSWORD=mysql_password
- WP_DB_HOST=mariadb:3306
- WP_TITLE=inception_wordpress
- WP_ADMIN=wordpress_admin
- WP_ADMIN_PASSWORD=wordpress_admin_password
- WP_ADMIN_EMAIL=admin_mail@email.fr
- WP_USER=wordpress_user
- WP_USER_PASSWORD=wordpress_user_password
- WP_USER_EMAIL=wordpress_user@email.fr
- DOMAIN_NAME=my_server.fr
- MYSQL_ROOT_PASSWORD=root_password

Ajouter dans **/etc/hosts** le nom de domaine : **127.0.0.1 my_server.fr**
