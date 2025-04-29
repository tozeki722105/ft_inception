#! /bin/bash

DB_ROOT_PASS=$(cat /run/secrets/db_root_pass)
DB_USER_PASS=$(cat /run/secrets/db_user_pass)

service mariadb start

mariadb -e "alter user 'root'@'localhost' identified by '${DB_ROOT_PASS}';" 2>/dev/null \
	|| echo "The root password is already set"

mariadb -u root -p"${DB_ROOT_PASS}" -e "show databases" | grep ${DB_NAME} 1>/dev/null
if [[ $? -eq 1 ]]; then
	echo "Create a database for wordpress"
	mariadb -u root -p"${DB_ROOT_PASS}" -e "create database ${DB_NAME}" && \
	mariadb -u root -p"${DB_ROOT_PASS}" -e "create user '${DB_USER_NAME}'@'%' identified by '${DB_USER_PASS}'" && \
	mariadb -u root -p"${DB_ROOT_PASS}" -e "grant all on ${DB_NAME}.* to '${DB_USER_NAME}'@'%'" && \
	mariadb -u root -p"${DB_ROOT_PASS}" -e "show grants for '${DB_USER_NAME}'@'%'" && \
	mariadb -u root -p"${DB_ROOT_PASS}" -e "flush privileges"
	echo "Finish for creating a database for wordpress"
fi

service mariadb stop

mysqld_safe

