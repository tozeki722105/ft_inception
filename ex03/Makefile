include ./srcs/.env

all: 
	mkdir -p ${LOCAL_VOLUME_PATH}/data/wp ${LOCAL_VOLUME_PATH}/data/db
	make up

up:
	docker compose -f srcs/docker-compose.yml up -d --build 

down:
	docker compose -f srcs/docker-compose.yml down

re: down up 

clean: down
	sudo rm -rf ${LOCAL_VOLUME_PATH}/data

fclean: clean
	docker volume ls -q | xargs docker volume rm
	docker image ls | awk 'NR>1 {print \$1,\$3}' | grep -e mariadb -e nginx -e wordpress | awk '{print \$2}' | xargs docker image rm
	docker builder prune -f

none_clean:
	docker image ls | awk 'NR>1 {print \$1,\$3}' | grep '<none>' | awk '{print \$2}' | xargs docker image rm

	
