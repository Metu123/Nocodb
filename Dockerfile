# Base image with PHP + Apache
FROM php:8.3-apache

WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev libonig-dev libxml2-dev libcurl4-openssl-dev \
    libssl-dev libfreetype6-dev libjpeg62-turbo-dev libicu-dev default-mysql-server \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd bcmath sockets \
    && pecl install mongodb && docker-php-ext-enable mongodb

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy DreamFactory source
COPY . .

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Copy .env
COPY .env .env

# Expose port 80
EXPOSE 80

# Start MySQL + Apache
CMD service mysql start && apache2-foreground
