NAME = narra

.PHONY: start debug log stop restart down

start:
	export DEBUG=false; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml up

debug:
	export DEBUG=true; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml up

log:
	export DEBUG=false; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml logs

stop:
	export DEBUG=false; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml stop

restart:
	export DEBUG=false; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml restart

down:
	export DEBUG=false; cd docker; docker-compose -p $(NAME) -f ./docker-compose.yml -f ./docker-compose.development.yml down
