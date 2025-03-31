#! /bin/bash

service mariadb start && \
mariadb -e "create database ${DB_NAME}" && \
mariadb -e "create user '${DB_USER_NAME}'@'%' identified by '${DB_PASS}'" && \
mariadb -e "grant all on ${DB_NAME}.* to '${DB_USER_NAME}'@'%'" && \
mariadb -e "show grants for '${DB_USER_NAME}'@'%'" && \
mariadb -e "flush privileges" && \
service mariadb stop