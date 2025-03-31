FROM debian:bullseye

RUN apt update && apt install -y vim less nginx openssl

COPY ./site-available_default /etc/nginx/sites-available/default

RUN mkdir /etc/nginx/ssl && \
	openssl genrsa -out /etc/nginx/ssl/server.key 2048 && \
	openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr \
	-subj "/C=../ST=../L=../O=../CN=ft.42.fr" && \
	openssl x509 -signkey /etc/nginx/ssl/server.key -req -in /etc/nginx/ssl/server.csr \
	-out /etc/nginx/ssl/server.crt -days 365

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]