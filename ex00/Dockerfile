FROM debian:bullseye

RUN apt update && apt install -y vim less nginx mariadb-server php-fpm wget tar

COPY ./site-available_default /etc/nginx/sites-available/default

COPY ./50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./index.php /var/www/html/index.php

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]