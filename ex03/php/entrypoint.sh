#! /bin/bash

if [[ ! -e /var/www/html/wordpress/wp-config.php ]]; then
	cd /var/www/html/wordpress/
	wp config create --dbname=${DB_NAME} --dbuser=${DB_USER_NAME} --dbpass=${DB_PASS} --dbhost=dbcon --dbcharset=utf8mb4 --allow-root
	wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASS} --admin_email=${WP_ADMIN_EMAIL} --skip-email --path=/var/www/html/wordpress --allow-root
	wp user create ${WP_USER_LOGINNAM} ${WP_USER_EMAIL} --role=${WP_USER_ROLE} --user_pass=${WP_USER_PASS} --display_name=${WP_USER_DISPLAYNAME} --path=/var/www/html/wordpress --allow-root
fi
php-fpm7.4 -F
