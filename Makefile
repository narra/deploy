ifneq (,$(wildcard ./docker/.env))
    include ./docker/.env
    export
endif

.PHONY: start deploy dev log stop down

start: development

production:
	cd docker; docker-compose -p $(NARRA_STACK_NAME) -f ./docker-compose.yml up

development:
	cd docker; docker-compose -p $(NARRA_STACK_NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml up

log:
	cd docker; docker-compose -p $(NARRA_STACK_NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml logs

stop:
	cd docker; docker-compose -p $(NARRA_STACK_NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml stop

down:
	cd docker; docker-compose -p $(NARRA_STACK_NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml down
