#! /bin/bash

service mariadb start

mariadb -e "create database wordpress";

mariadb -e "create user 'test'@'%' identified by 'test'";

mariadb -e "grant all on wordpress.* to 'test'@'%'";

mariadb -e "show grants for 'test'@'%'";

mariadb -e "flush privileges";

service mariadb stop