.DEFAULT_GOAL := help

# PHONY prevents filenames being used as targets
.PHONY: help info rebuild status start stop restart build import_db

help: ## show this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info: ## dump Makefile variables to screen
	@echo -e $(_MAKEFILE_VARIABLES)

build: ## build Docker Compose images
	docker-compose build --parallel

start: ## start single Docker Compose service
	docker-compose up

stop: ## stop Docker Compose
	docker-compose down -v --remove-orphans

restart: ## restart Docker Compose
	stop start status

status: ## show Docker Compose process list
	docker-compose ps

rebuild: stop build start status

import_db:
ifdef DB_FILE
	@docker-compose exec -T database pg_restore -C --clean --no-acl --no-owner -U postgres -d cms < ${DB_FILE}
else
	@echo -e "No filename given for database source file"
endif
