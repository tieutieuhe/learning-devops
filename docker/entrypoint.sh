#!/bin/sh

./docker/wait-for-it.sh http://127.0.0.1:3306 -- echo "Database is up"

if [ ! -f "vendor/autoload.php" ]; then
	composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
	echo "Create env file"
	cp .env.example .env
else
	echo "env is exists."
fi
php artisan migrate:install
php artisan key:generate
php artisan cache:clear
php artisan config:clear
php artisan route:clear

php artisan serve --port=$PORT --host=0.0.0.0 --env=.env
exec docker-php-entrypoint "$@"