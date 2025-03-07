FROM debian:bullseye

RUN apt update && apt install -y vim less php-fpm wget tar

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]