IMAGE_NAME := test
DOCKERFILE_PATH := ./Dockerfile
CONTEXT_PATH := ./ #Dockerfileはこの相対パスを元に実行される
CONTAINAR_NAME := testcon

all:
	docker build -t ${IMAGE_NAME} -f ${DOCKERFILE_PATH} ${CONTEXT_PATH}

run:
	docker run -p 80:80 -it ${IMAGE_NAME} 
#--name ${CONTAINAR_NAME}

con_clean:
	docker ps -a -f ancestor=${IMAGE_NAME} | awk 'NR>1 {print $$1}' | xargs docker rm

img_clean:
	docker image rm ${IMAGE_NAME}	

none_clean:
	docker image ls | awk 'NR>1 {print $$1,$$3}' | grep '<none>' | awk '{print $$2}' | xargs docker image rm

clean: con_clean

fclean : clean img_clean