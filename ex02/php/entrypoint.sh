#! /bin/bash

if [[ ! -e /var/www/html/wordpress ]]; then
	cd /var/www/html/wordpress/
	wp config create --dbname=wordpress --dbuser=test --dbpass=test --dbhost=dbcon --dbcharset=utf8mb4 --allow-root	
fi

php-fpm7.4 -F

