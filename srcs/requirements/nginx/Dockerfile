FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

# RUN apt install -y vim less htop

COPY ./default.conf /etc/nginx/sites-available/default

EXPOSE 443

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]