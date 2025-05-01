FROM debian:bullseye

RUN apt update && apt install -y vim less mariadb-server htop mariadb-client

COPY ./50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]