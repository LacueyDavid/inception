DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml
DATA_DIRS = /home/dlacuey/data/{mariadb,wordpress}

all: create-dirs check-env up

create-dirs:
	mkdir -p $(DATA_DIRS)

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
	sudo rm -rf /home/dlacuey/data/{mariadb,wordpress}

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
