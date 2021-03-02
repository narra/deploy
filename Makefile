# Absolute path to .env file
ROOT = $(shell pwd)
ENV_FILE = $(ROOT)/docker/narra.env
DOCKER_FILE = $(ROOT)/docker/docker-compose.yml
DOCKER_FILE_DEVELOPMENT = $(ROOT)/docker/docker-compose.development.yml
COMPOSE_COMMAND = -p $(NARRA_STACK_NAME) --env-file $(ENV_FILE) -f $(DOCKER_FILE)

# Use for makefile
ifneq (,$(wildcard $(ENV_FILE)))
    include $(ENV_FILE)
    export
endif

.PHONY: deploy redeploy dev stop clean reset

deploy:
	ROOT=$(ROOT) ENV_FILE=$(ENV_FILE) docker-compose $(COMPOSE_COMMAND) up -d

redeploy: stop clean deploy

dev:
	ROOT=$(ROOT) ENV_FILE=$(ENV_FILE) docker-compose $(COMPOSE_COMMAND) -f $(DOCKER_FILE_DEVELOPMENT) up

stop:
	ROOT=$(ROOT) ENV_FILE=$(ENV_FILE) docker-compose $(COMPOSE_COMMAND) stop

clean:
	docker system prune -f

reset: clean
	docker volume prune -f

purge: clean reset
	docker system prune --all -f

logs:
	ROOT=$(ROOT) ENV_FILE=$(ENV_FILE) docker-compose $(COMPOSE_COMMAND) logs -f -t
