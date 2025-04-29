FROM debian:bullseye

RUN apt update && apt install -y vim less nginx openssl htop

COPY ./site-available_default /etc/nginx/sites-available/default

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]