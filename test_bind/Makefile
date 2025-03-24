CON_NAME := my-mariadb-container
IMG_NAME := my-mariadb
DOCKERFILE_DIR_PATH := ./db/

all:
	mkdir -p ./data/db
	docker build -t ${IMG_NAME} -f ${DOCKERFILE_DIR_PATH}Dockerfile .

run:
	docker volume create --driver local --opt type=none --opt device=/home/tozeki/Github/inception/test_bind/data/db --opt o=bind test_vol
	docker run -d --name ${CON_NAME} \
	-v test_vol:/var/lib/mysql \
	-p 3305:3305 ${IMG_NAME}

# /var/lib/docker/volumesにも存在しない
fail_run:
	docker run -d --name ${CON_NAME} \
	-v /home/tozeki/Github/inception/test_bind/data/db:/var/lib/mysql \
	-p 3305:3305 ${IMG_NAME}

clean:
	docker stop ${CON_NAME}
	docker rm ${CON_NAME}

fclean: clean
	docker image rm ${IMG_NAME}
	rm -rf ./data

vol_clean:
	docker volume rm test_vol

