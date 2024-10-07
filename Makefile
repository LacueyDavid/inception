DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml

all: create-dirs check-env up

create-dirs:
	/bin/bash -c 'mkdir -p /home/dlacuey/data/{mariadb,wordpress}'

check-env:
	@if [ ! -f srcs/.env ];			\
	then echo ".env file not found.";	\
	exit 1;					\
	fi

build: create-dirs
	$(DOCKER_COMPOSE) build

up: 
	$(DOCKER_COMPOSE) up -d

down: 
	$(DOCKER_COMPOSE) down

restart: down up

logs: 
	$(DOCKER_COMPOSE) logs

clean: 
	$(DOCKER_COMPOSE) down -v
	/bin/bash -c 'sudo rm -rf /home/dlacuey/data/{mariadb,wordpress}'

prune: down
	sudo docker rm -vf $$(sudo docker ps -aq) || true
	sudo docker rmi -f $$(sudo docker images -aq) || true
	sudo docker network prune -f
	sudo docker system prune -a -f

status: 
	$(DOCKER_COMPOSE) ps

# Container shell access
shell-nginx: 
	$(DOCKER_COMPOSE) exec nginx /bin/sh
shell-wordpress: 
	$(DOCKER_COMPOSE) exec wordpress /bin/sh
shell-mariadb: 
	$(DOCKER_COMPOSE) exec mariadb /bin/sh

.PHONY: all create-dirs check-env build up down restart logs clean prune status \
shell-nginx shell-wordpress shell-mariadb
