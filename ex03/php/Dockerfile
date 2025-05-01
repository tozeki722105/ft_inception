FROM debian:bullseye

RUN apt update && apt install -y vim less php7.4-fpm php7.4-mysqli curl htop mariadb-client

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir -p /var/www/html/wordpress && \
	wp core download --path=/var/www/html/wordpress --allow-root

RUN mkdir /run/php

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]