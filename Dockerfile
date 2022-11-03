FROM php:7.4-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql sockets
RUN curl -sS https://getcomposer.org/installer​ | php -- \
     --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 8080

ENV HOST=0.0.0.0
ENV PORT=8080

WORKDIR /app
COPY . .
RUN composer install

CMD [ "php", "artisan", "serve", "--port=8080" ]