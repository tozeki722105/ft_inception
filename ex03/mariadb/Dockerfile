FROM debian:bullseye

RUN apt update && apt install -y vim less mariadb-server htop

COPY ./50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]