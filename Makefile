# Absolute path to .env file
ENV_FILE = $(shell pwd)/docker/narra.env
DOCKER_FILE = $(shell pwd)/docker/docker-compose.yml
DOCKER_FILE_DEVELOPMENT = $(shell pwd)/docker/docker-compose.development.yml

# Use for makefile
ifneq (,$(wildcard $(ENV_FILE)))
    include $(ENV_FILE)
    export
endif

.PHONY: deploy redeploy dev stop clean reset

deploy:
	ENV_FILE=$(ENV_FILE) docker-compose -p $(NARRA_STACK_NAME) --env-file $(ENV_FILE) -f $(DOCKER_FILE) up -d

redeploy: stop clean deploy

dev:
	ENV_FILE=$(ENV_FILE) docker-compose -p $(NARRA_STACK_NAME) --env-file $(ENV_FILE) -f $(DOCKER_FILE) -f $(DOCKER_FILE_DEVELOPMENT) up

stop:
	ENV_FILE=$(ENV_FILE) docker-compose -p $(NARRA_STACK_NAME) --env-file $(ENV_FILE) -f $(DOCKER_FILE) stop

clean:
	docker system prune -f

reset: clean
	docker volume prune -f

logs:
	ENV_FILE=$(ENV_FILE) docker-compose -p $(NARRA_STACK_NAME) --env-file $(ENV_FILE) -f $(DOCKER_FILE) logs -f -t
