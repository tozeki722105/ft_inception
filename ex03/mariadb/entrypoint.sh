#! /bin/bash

DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)
DB_USER_PASS=$(cat /run/secrets/db_user_pass)

service mariadb start

mariadb -e "show databases" 2>/dev/null  | grep ${DB_NAME} 1>/dev/null
if [[! $? -eq 1]]; then
	mariadb -e "create database ${DB_NAME}" && \
	mariadb -e "create user '${DB_USER_NAME}'@'%' identified by '${DB_USER_PASS}'" && \
	mariadb -e "grant all on ${DB_NAME}.* to '${DB_USER_NAME}'@'%'" && \
	mariadb -e "show grants for '${DB_USER_NAME}'@'%'" && \
	mariadb -e "flush privileges"
fi

service mariadb stop

mysqld_safe

