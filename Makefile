.DEFAULT_GOAL := help

CONTAINER ?= drupal

# PHONY prevents filenames being used as targets
.PHONY: help info rebuild status start stop restart build import_db shell

help: ## show this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info: ## dump Makefile variables to screen
	@echo -e $(_MAKEFILE_VARIABLES)

build: ## build Docker Compose images
	docker-compose build

start: ## start single Docker Compose service in detached mode
	docker-compose up -d

stop: ## stop Docker Compose
	docker-compose down --remove-orphans

restart: stop start status ## restart Docker Compose

status: ## show Docker Compose process list
	docker-compose ps

rebuild: stop build start status ## stop running containers, build and start them

shell: ## execute command on container. Usage: make CONTAINER=database shell
	docker-compose exec ${CONTAINER} sh

import_db: ## import postgres database. Usage: make DB_FILE=psql.gz import_db
ifdef DB_FILE
	@docker-compose exec -T database pg_restore -C --clean --no-acl --no-owner -U postgres -d cms < ${DB_FILE}
else
	@echo -e "No filename given for database source file"
endif
