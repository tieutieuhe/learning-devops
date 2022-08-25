FROM php:8.1 as php

RUN apt-get update -y && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y unzip libpq-dev libcurl4-gnutls-dev
RUN docker-php-ext-install pdo pdo_mysql bcmath

WORKDIR /var/www/html
COPY . .
COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

RUN chmod +x ./docker/entrypoint.sh
RUN chmod 777 ./storage/logs/laravel.log

ENV PORT=8000
ENTRYPOINT ["./docker/entrypoint.sh"]