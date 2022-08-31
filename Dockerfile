FROM php:8.1 as php

RUN apt-get update -y && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y libzip-dev zip && docker-php-ext-configure zip && docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

WORKDIR /var/www/html
COPY --from=composer:2.3.5 /usr/bin/composer /usr/bin/composer

RUN chmod +x ./docker/entrypoint.sh

ENV PORT=8000
