FROM debian:bullseye

RUN apt update && \
apt install -y mariadb-server

# bind-address を 0.0.0.0 に変更
RUN sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start && \
    mariadb -e "create database testdb" && \
    mariadb -e "create user 'test'@'%' identified by 'test'" && \
    mariadb -e "grant all on testdb.* to 'test'@'%'" && \
    mariadb -e "show grants for 'test'@'%'" && \
    mariadb -e "flush privileges" && \
    service mariadb stop

# ポートの公開
EXPOSE 3305

# パーミッションエラーを避けるために必要な設定
RUN chown -R mysql:mysql /var/lib/mysql /etc/mysql /var/run/mysqld

COPY ep.sh /usr/local/bin/ep.sh

RUN chmod +x /usr/local/bin/ep.sh

ENTRYPOINT ["/usr/local/bin/ep.sh"]