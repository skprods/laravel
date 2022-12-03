init: \
	docker-clean \
	docker-up \
	composer-install \
	db-migration \
	db-migration-test

up: docker-up
stop: docker-stop

docker-clean:
	docker compose down -v --remove-orphans
docker-up:
	docker compose up --build -d
docker-stop:
	docker compose stop

exec-php-cli:
	docker compose run --rm php-cli sh

composer-install:
	docker compose run --rm php-cli composer install
composer-update:
	docker compose run --rm php-cli composer update
composer-validate:
	docker compose run --rm php-cli composer validate --no-check-all

db-migration:
	docker compose run --rm php-cli php artisan migrate:fresh --drop-views
db-migration-test:
	docker compose exec mysql mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS app_test;"
	docker compose run --rm -e DB_DATABASE=app_test php-cli php artisan migrate:fresh --drop-views
