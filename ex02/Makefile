NGINX_DIR_PATH := nginx/
NGINX_IMAGE_NAME := nginximg
NGINX_DOCKERFILE_PATH := ./Dockerfile
NGINX_CONTEXT_PATH := ./ #Dockerfileはこの相対パスを元に実行される
NGINX_CONTAINAR_NAME := nginxcon
NGINX_ALIAS_NAME := nginx #CONTAINER_NAMEがあるから不要？

PHP_DIR_PATH := php/
PHP_IMAGE_NAME := phpimg
PHP_DOCKERFILE_PATH := ./Dockerfile
PHP_CONTEXT_PATH := ./ #Dockerfileはこの相対パスを元に実行される
PHP_CONTAINAR_NAME := phpcon
PHP_ALIAS_NAME := php #CONTAINER_NAMEがあるから不要？

DB_DIR_PATH := mariadb/
DB_IMAGE_NAME := dbimg
DB_DOCKERFILE_PATH := ./Dockerfile
DB_CONTEXT_PATH := ./ #Dockerfileはこの相対パスを元に実行される
DB_CONTAINAR_NAME := dbcon
DB_ALIAS_NAME := db #CONTAINER_NAMEがあるから不要？

NETWORK_NAME := test

BIND_PATH := $(PWD)/${PHP_DIR_PATH}
DST_PATH := /var/www/html/

out:
	echo "docker run -d --network ${NETWORK_NAME} --network-alias ${DB_ALIAS_NAME} \
		--name ${DB_CONTAINAR_NAME} ${DB_IMAGE_NAME}"

all:
	docker build --no-cache -t ${DB_IMAGE_NAME} -f ${DB_DIR_PATH}${DB_DOCKERFILE_PATH} ${DB_DIR_PATH}${DB_CONTEXT_PATH}
	docker build --no-cache -t ${PHP_IMAGE_NAME} -f ${PHP_DIR_PATH}${PHP_DOCKERFILE_PATH} ${PHP_DIR_PATH}${PHP_CONTEXT_PATH}
	docker build --no-cache -t ${NGINX_IMAGE_NAME} -f ${NGINX_DIR_PATH}${NGINX_DOCKERFILE_PATH} ${NGINX_DIR_PATH}${NGINX_CONTEXT_PATH}

# mkdir -p $(HOME)/data/
# mkdir $(HOME)/data/db mkdir $(HOME)/data/wp
run:
	docker network create ${NETWORK_NAME}
	docker run -d --network ${NETWORK_NAME} --network-alias ${PHP_ALIAS_NAME} \
		--mount type=bind,src=${BIND_PATH}index.php,dst=${DST_PATH}index.php \
		--name ${PHP_CONTAINAR_NAME}  ${PHP_IMAGE_NAME}
	docker run -d --network ${NETWORK_NAME} --network-alias ${NGINX_ALIAS_NAME} \
		--mount type=bind,src=${BIND_PATH}index.php,dst=${DST_PATH}index.php \
		--name ${NGINX_CONTAINAR_NAME} -p 80:80 ${NGINX_IMAGE_NAME}
	docker run -d --network ${NETWORK_NAME} --network-alias ${DB_ALIAS_NAME} \
		--name ${DB_CONTAINAR_NAME} ${DB_IMAGE_NAME}

connect_clean:
	docker network disconnect ${NETWORK_NAME} ${PHP_CONTAINAR_NAME}
	docker network disconnect ${NETWORK_NAME} ${NGINX_CONTAINAR_NAME}
	docker network disconnect ${NETWORK_NAME} ${DB_CONTAINAR_NAME}

con_clean:
	docker stop ${PHP_CONTAINAR_NAME}
	docker stop ${NGINX_CONTAINAR_NAME}
	docker stop ${DB_CONTAINAR_NAME}
	docker rm ${PHP_CONTAINAR_NAME}
	docker rm ${NGINX_CONTAINAR_NAME}
	docker rm ${DB_CONTAINAR_NAME}

net_clean:
	docker network rm ${NETWORK_NAME}

img_clean:
	docker image rm ${PHP_IMAGE_NAME} ${NGINX_IMAGE_NAME} ${DB_IMAGE_NAME}

none_clean:
	docker image ls | awk 'NR>1 {print $$1,$$3}' | grep '<none>' | awk '{print $$2}' | xargs docker image rm

clean: connect_clean con_clean net_clean

fclean: clean img_clean