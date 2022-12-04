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
	docker compose exec postgres sh /scripts/init-testing-db.sh
	docker compose run --rm -e DB_DATABASE=app_test php-cli php artisan migrate:fresh --drop-views

lint: \
	composer-validate \
	phplint \
	php-cs-fixer \
	phpstan \
	psalm
phplint:
	docker compose run --rm php-cli vendor/bin/phplint
php-cs-fixer:
	docker compose run --rm php-cli vendor/bin/php-cs-fixer fix --dry-run --diff --show-progress=dots --allow-risky=yes -v
php-cs-fixer-fix:
	docker compose run --rm php-cli vendor/bin/php-cs-fixer fix --verbose --diff --show-progress=dots --allow-risky=yes
phpstan:
	docker compose run --rm php-cli vendor/bin/phpstan analyse --xdebug
phpstan-generate-baseline:
	docker compose run --rm php-cli vendor/bin/phpstan analyse --generate-baseline
psalm:
	docker compose run --rm php-cli vendor/bin/psalm
psalm-generate-baseline:
	docker compose run --rm php-cli vendor/bin/psalm --no-cache --set-baseline=psalm-baseline.xml
