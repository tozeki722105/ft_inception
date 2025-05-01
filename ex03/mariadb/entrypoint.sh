#! /bin/bash

DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)
DB_USER_PASS=$(cat /run/secrets/db_user_pass)

service mariadb start

sleep 5

mariadb -e "show databases" 2>/dev/null | grep ${DB_NAME} 1>/dev/null
if (($? == 1)); then
	echo "Create a database for WordPress..."
	mariadb -e "create database ${DB_NAME}" && \
	mariadb -e "create user '${DB_USER_NAME}'@'%' identified by '${DB_USER_PASS}'" && \
	mariadb -e "grant all on ${DB_NAME}.* to '${DB_USER_NAME}'@'%'" && \
	mariadb -e "show grants for '${DB_USER_NAME}'@'%'" && \
	mariadb -e "flush privileges" && \
	echo "Finish for creating a database for WordPress"
else
	echo "Already exit a database for WordPress"
fi

service mariadb stop

mysqld_safe
