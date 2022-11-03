FROM php:7.4-fpm

# RUN docker-php-ext-install pdo pdo_mysql sockets
# RUN curl -sS https://getcomposer.org/installer​ | php -- \
#      --install-dir=/usr/local/bin --filename=composer

# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# EXPOSE 8080

# ENV HOST=0.0.0.0
# ENV PORT=8080

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libnig-dev \
    libxml2-dev \
    zip \
    unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install pdo_mysql mbstring


WORKDIR /app
COPY composer.json .
RUN composer install --no-scripts
COPY . .

# CMD [ "php", "artisan", "serve", "--host=0.0.0.0", "--port=8080" ]
CMD php artisan serve --host=0.0.0.0 --port=80