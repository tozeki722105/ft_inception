#! /bin/bash

DB_USER_PASS=$(cat /run/secrets/db_user_pass)

service mariadb start

sleep 5

mariadb -e "SHOW DATABASES" 2>/dev/null | grep ${DB_NAME} 1>/dev/null
if (($? == 1)); then
	echo "Creating WordPress database and user..."
	mariadb -e "CREATE DATABASE ${DB_NAME}" && \
	mariadb -e "CREATE USER '${DB_USER_NAME}'@'%' IDENTIFIED BY '${DB_USER_PASS}'" && \
	mariadb -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER_NAME}'@'%'" && \
	mariadb -e "SHOW GRANTS FOR '${DB_USER_NAME}'@'%'" && \
	mariadb -e "FLUSH PRIVILEGES" && \
	echo "WordPress database and user created successfully."
else
	echo "WordPress database already exists."
fi

service mariadb stop

mysqld_safe
