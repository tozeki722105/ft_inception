#! /bin/bash

SSL_DIR="/etc/nginx/ssl"

sed -i "s/server_name _;/server_name ${DOMAIN_NAME};/" /etc/nginx/sites-available/default

echo "Initializing NGINX web server with SSL..."
mkdir ${SSL_DIR} && \
openssl genrsa -out "${SSL_DIR}/server.key" 2048 && \
openssl req -new -key ${SSL_DIR}/server.key -out ${SSL_DIR}/server.csr \
	-subj "/C=${SITE_COUNTRY}/ST=${SITE_STATE_OR_PROVINCE}/L=${SITE_LOCALITY}/O=${SITE_ORGANIZATION}/CN=${DOMAIN_NAME}" && \
openssl x509 -req -in ${SSL_DIR}/server.csr -signkey ${SSL_DIR}/server.key \
	-out ${SSL_DIR}/server.crt -days 365
echo "SSL configuration completed."

nginx -g "daemon off;"
