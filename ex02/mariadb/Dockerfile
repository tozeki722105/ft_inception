FROM debian:bullseye

RUN apt update && apt install -y vim less mariadb-server 

RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start && \
    mariadb -e "create database wordpress" && \
    mariadb -e "create user 'test'@'%' identified by 'test'" && \
    mariadb -e "grant all on wordpress.* to 'test'@'%'" && \
    mariadb -e "show grants for 'test'@'%'" && \
    mariadb -e "flush privileges" && \
    service mariadb stop

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]