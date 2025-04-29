#! /bin/bash

SSL_DIR="/etc/nginx/ssl"

sleep 15

mkdir ${SSL_DIR} && \
openssl genpkey -algorithm ED25519 -out "${SSL_DIR}/server.key" && \
openssl req -new -key ${SSL_DIR}/server.key -out ${SSL_DIR}/server.csr \
	-subj "/C=${SITE_COUNTRY}/ST=${SITE_STATE_OR_PROVINCE}/L=${SITE_LOCALITY}/O=${SITE_ORGANIZATION}/CN=${DOMAIN_NAME}" && \
openssl x509 -req -in ${SSL_DIR}/server.csr -signkey ${SSL_DIR}/server.key \
	-out ${SSL_DIR}/server.crt -days 365

nginx -g "daemon off;"
