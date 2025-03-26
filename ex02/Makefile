NGINX_DIR_PATH := nginx/
NGINX_IMAGE_NAME := nginximg
NGINX_CON_NAME := nginxcon

PHP_DIR_PATH := php/
PHP_IMAGE_NAME := phpimg
PHP_CON_NAME := phpcon

DB_DIR_PATH := mariadb/
DB_IMAGE_NAME := dbimg
DB_CON_NAME := dbcon

NETWORK_NAME := test_net
LOCAL_VOLUME_PATH := /home/tozeki/Github/inception/ex02/data/
DB_VOLUME := db_vol
WP_VOLUME := wp_vol

test:
	echo "docker run -d --network ${NETWORK_NAME} --network-alias ${DB_ALIAS_NAME} \
		--name ${DB_CON_NAME} ${DB_IMAGE_NAME}"

img:
	mkdir -p ./data/db ./data/wp
	docker build -t ${DB_IMAGE_NAME} -f ${DB_DIR_PATH}Dockerfile ${DB_DIR_PATH}.
	docker build -t ${PHP_IMAGE_NAME} -f ${PHP_DIR_PATH}Dockerfile ${PHP_DIR_PATH}.
	docker build -t ${NGINX_IMAGE_NAME} -f ${NGINX_DIR_PATH}Dockerfile ${NGINX_DIR_PATH}.

run:
	docker volume create --driver local --opt type=none \
		--opt device=${LOCAL_VOLUME_PATH}db \
		--opt o=bind ${DB_VOLUME}
	docker volume create --driver local --opt type=none \
		--opt device=${LOCAL_VOLUME_PATH}wp \
		--opt o=bind ${WP_VOLUME}
	docker network create ${NETWORK_NAME}
	docker run -d --network ${NETWORK_NAME} \
		--mount type=volume,src=${DB_VOLUME},dst=/var/lib/mysql \
		--name ${DB_CON_NAME} ${DB_IMAGE_NAME}
	docker run -d --network ${NETWORK_NAME} \
		--mount type=volume,src=${WP_VOLUME},dst=/var/www/html/wordpress \
		--name ${PHP_CON_NAME}  ${PHP_IMAGE_NAME}
	docker run -d -p 80:80 --network ${NETWORK_NAME} \
		--mount type=volume,src=${WP_VOLUME},dst=/var/www/html/wordpress \
		--name ${NGINX_CON_NAME} ${NGINX_IMAGE_NAME}
	
vol_clean:
	docker volume rm ${WP_VOLUME} ${DB_VOLUME}

connect_clean:
	docker network disconnect ${NETWORK_NAME} ${PHP_CON_NAME}
	docker network disconnect ${NETWORK_NAME} ${NGINX_CON_NAME}
	docker network disconnect ${NETWORK_NAME} ${DB_CON_NAME}

con_clean:
	docker stop ${PHP_CON_NAME}
	docker stop ${NGINX_CON_NAME}
	docker stop ${DB_CON_NAME}
	docker rm ${PHP_CON_NAME}
	docker rm ${NGINX_CON_NAME}
	docker rm ${DB_CON_NAME}

net_clean:
	docker network rm ${NETWORK_NAME}

img_clean:
	docker image rm ${PHP_IMAGE_NAME} ${NGINX_IMAGE_NAME} ${DB_IMAGE_NAME}

none_clean:
	docker image ls | awk 'NR>1 {print $$1,$$3}' | grep '<none>' | awk '{print $$2}' | xargs docker image rm

clean: connect_clean con_clean net_clean

fclean: clean img_clean vol_clean