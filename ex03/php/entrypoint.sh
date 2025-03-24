#! /bin/bash

if [[ ! -e /var/www/html/wordpress/wp-config.php ]]; then
	cd /var/www/html/wordpress/
	wp config create --dbname=wordpress --dbuser=test --dbpass=test --dbhost=dbcon --dbcharset=utf8mb4 --allow-root	
	wp core install --url=ft.42.fr --title=inception --admin_user=master --admin_password=pass --admin_email=info@example.com --path=/var/www/html/wordpress --allow-root
fi

php-fpm7.4 -F
