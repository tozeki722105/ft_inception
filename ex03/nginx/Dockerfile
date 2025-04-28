FROM debian:bullseye

RUN apt update && apt install -y vim less nginx openssl htop

COPY ./site-available_default /etc/nginx/sites-available/default

ARG SITE_COUNTRY SITE_STATE_OR_PROVINCE SITE_LOCALITY SITE_ORGANIZATION DOMAIN_NAME
ENV SITE_COUNTRY=${SITE_COUNTRY} SITE_STATE_OR_PROVINCE=${SITE_STATE_OR_PROVINCE} SITE_LOCALITY=${SITE_LOCALITY} \
	SITE_ORGANIZATION=${SITE_ORGANIZATION} DOMAIN_NAME=${DOMAIN_NAME}

RUN mkdir /etc/nginx/ssl && \
	openssl genrsa -out /etc/nginx/ssl/server.key 2048 && \
	openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr \
	-subj "/C=${SITE_COUNTRY}/ST=${SITE_STATE_OR_PROVINCE}/L=${SITE_LOCALITY}/O=${SITE_ORGANIZATION}/CN=${DOMAIN_NAME}" && \
	openssl x509 -signkey /etc/nginx/ssl/server.key -req -in /etc/nginx/ssl/server.csr \
	-out /etc/nginx/ssl/server.crt -days 365

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]