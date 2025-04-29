#! /bin/bash

sleep 15

mkdir /etc/nginx/ssl && \
openssl genrsa -out /etc/nginx/ssl/server.key 2048 && \
openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr \
-subj "/C=${SITE_COUNTRY}/ST=${SITE_STATE_OR_PROVINCE}/L=${SITE_LOCALITY}/O=${SITE_ORGANIZATION}/CN=${DOMAIN_NAME}" && \
openssl x509 -signkey /etc/nginx/ssl/server.key -req -in /etc/nginx/ssl/server.csr \
-out /etc/nginx/ssl/server.crt -days 365

nginx -g "daemon off;"
