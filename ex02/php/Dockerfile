FROM debian:bullseye

RUN apt update && apt install -y vim less php-fpm php7.4-mysqli curl tar

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

RUN /usr/local/bin/wordpress.sh

RUN mkdir /run/php

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]