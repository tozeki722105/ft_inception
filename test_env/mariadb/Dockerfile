FROM debian:bullseye

RUN apt update && apt install -y vim less mariadb-server htop

RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

ARG DB_NAME
ARG DB_USER_NAME
ARG DB_PASS

RUN echo ${DB_NAME} ${DB_USER_NAME} ${DB_PASS}

# RUN service mariadb start && \
#     mariadb -e "create database ${DB_NAME}" && \
#     mariadb -e "create user '${DB_USER_NAME}'@'%' identified by '${DB_PASS}'" && \
#     mariadb -e "grant all on ${DB_NAME}.* to '${DB_USER_NAME}'@'%'" && \
#     mariadb -e "show grants for '${DB_USER_NAME}'@'%'" && \
#     mariadb -e "flush privileges" && \
#     service mariadb stop

COPY ./init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
RUN /usr/local/bin/init.sh

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]