# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

# Absolute path to .env file
NARRA_ROOT = $(shell pwd)
NARRA_ENV_FILE = $(NARRA_ROOT)/docker/narra.env

# Use for makefile
ifneq (,$(wildcard $(NARRA_ENV_FILE)))
    include $(NARRA_ENV_FILE)
    export
endif

NARRA_DOCKER_FILE = $(NARRA_ROOT)/docker/docker-compose.yml
NARRA_DOCKER_FILE_DEVELOPMENT = $(NARRA_ROOT)/docker/docker-compose.development.yml
NARRA_COMPOSE_COMMAND = -p $(NARRA_STACK_NAME) --env-file $(NARRA_ENV_FILE) -f $(NARRA_DOCKER_FILE)

.PHONY: deploy redeploy dev stop logs clean reset purge

deploy:
	NARRA_ROOT=$(NARRA_ROOT) NARRA_ENV_FILE=$(NARRA_ENV_FILE) docker-compose $(NARRA_COMPOSE_COMMAND) up -d

redeploy: stop clean deploy

dev:
	NARRA_ROOT=$(NARRA_ROOT) NARRA_ENV_FILE=$(NARRA_ENV_FILE) docker-compose $(NARRA_COMPOSE_COMMAND) -f $(NARRA_DOCKER_FILE_DEVELOPMENT) up

stop:
	NARRA_ROOT=$(NARRA_ROOT) NARRA_ENV_FILE=$(NARRA_ENV_FILE) docker-compose $(NARRA_COMPOSE_COMMAND) stop

logs:
	NARRA_ROOT=$(NARRA_ROOT) NARRA_ENV_FILE=$(NARRA_ENV_FILE) docker-compose $(NARRA_COMPOSE_COMMAND) logs -f -t

clean:
	docker system prune -f

reset: clean
	docker volume prune -f

purge: clean reset
	docker system prune --all -f
