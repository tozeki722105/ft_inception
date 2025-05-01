#! /bin/bash

DB_USER_PASS=$(cat /run/secrets/db_user_pass)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
WP_USER_PASS=$(cat /run/secrets/wp_user_pass)

limit=8
i=0
while ! mysqladmin ping -h dbcon -u ${DB_USER_NAME} -p${DB_USER_PASS} 2>/dev/null | grep "mysqld is alive" 2>/dev/null ; do
	if (($i == $limit)); then
		echo "Error: mysqladmin ping"
		exit 2
	fi
	((i++))
	sleep 2;
done

if [[ ! -f /var/www/html/wordpress/wp-config.php ]]; then
	echo "Install Wordpress..."
	cd /var/www/html/wordpress/
	wp config create --dbname=${DB_NAME} --dbuser=${DB_USER_NAME} --dbpass=${DB_USER_PASS} --dbhost=dbcon --dbcharset=utf8mb4 --allow-root && \
	wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_EMAIL} --skip-email --path=/var/www/html/wordpress --allow-root && \
	wp user create ${WP_USER_LOGINNAME} ${WP_USER_EMAIL} --role=${WP_USER_ROLE} --user_pass=${WP_USER_PASS} \
		--display_name=${WP_USER_DISPLAYNAME} --path=/var/www/html/wordpress --allow-root && \
	echo "Finish installation"
else
	echo "Already exit WordPress"
fi

php-fpm7.4 -F
