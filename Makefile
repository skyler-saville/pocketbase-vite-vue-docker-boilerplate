.PHONY: build up down logs rebuild \
        backend-up backend-logs backend-restart \
        frontend-up frontend-logs frontend-install frontend-build frontend-test \
        clear-data backup restore clean-docker status reset \
        seed-db lint-frontend dev superuser

# Define a variable for the sanitized project root directory name
PROJECT_NAME := $(shell basename $(shell pwd) | tr A-Z a-z)

build: 
	docker-compose build

up: 
	docker-compose up -d

down: 
	docker-compose down

logs: 
	docker-compose logs -f

rebuild:
	docker-compose build --no-cache && docker-compose up -d

backend-up: 
	docker-compose up -d backend

backend-logs: 
	docker-compose logs -f backend

frontend-up: 
	docker-compose up -d frontend

frontend-logs: 
	docker-compose logs -f frontend

frontend-install: 
	docker-compose run --rm frontend npm install

frontend-build: 
	docker-compose run --rm frontend npm run build

clear-data:
	docker volume rm $(PROJECT_NAME)_pocketbase_data || true

backup:
	docker-compose exec backend tar czf /app/pb_data_backup.tar.gz pb_data

restore:
	docker cp pb_data_backup.tar.gz backend:/app/
	docker-compose exec backend tar xzf /app/pb_data_backup.tar.gz -C /app

clean-docker: 
	@echo "WARNING: This will remove ALL unused Docker volumes, networks, containers, and images"
	@echo "(including other projects beside this one)."
	@echo "This action is irreversible and will free up disk space."
	@echo "If this is not your intended outcome, use the 'clear-data' target instead."
	@read -p "Are you sure you want to continue? (yes/no): " CONFIRM && [ "$$CONFIRM" = "yes" ] || { echo "Aborted."; exit 1; }
	@docker system prune -af --volumes

status: 
	docker-compose ps

reset: 
	docker-compose down -v

seed-db: 
	docker-compose exec backend ./pocketbase import ./seed.json

lint-frontend:
	docker-compose run --rm frontend npm run lint

dev:
	docker-compose up --build

superuser:
	./create_superuser.sh
