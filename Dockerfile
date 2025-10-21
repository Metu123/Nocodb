FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Install system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev libonig-dev libxml2-dev libcurl4-openssl-dev \
    libssl-dev libfreetype6-dev libjpeg62-turbo-dev libicu-dev default-mysql-server \
    ftp \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd bcmath sockets \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb

# Enable Apache rewrite
RUN a2enmod rewrite

# Environment variables for DreamFactory
ENV DB_HOST=127.0.0.1 \
    DB_PORT=3306 \
    DB_DATABASE=dreamfactory \
    DB_USERNAME=root \
    DB_PASSWORD=root \
    APP_URL=http://localhost

# Create composer.json inside the container
RUN echo '{
    "name": "dreamfactory/project",
    "description": "DreamFactory project",
    "require": {
        "php": ">=8.3",
        "mongodb/mongodb": "^2.0",
        "league/flysystem-ftp": "^3.0",
        "dreamfactory/df-file": "^0.9"
    },
    "autoload": {
        "psr-4": {
            "App\\\\": "app/"
        }
    }
}' > composer.json

# Install Composer and dependencies
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Copy application code
COPY . .

# Expose port 80
EXPOSE 80

# Start MySQL and Apache together
# Use a script to wait for MySQL to initialize
RUN echo '#!/bin/bash\n\
service mysql start\n\
sleep 10\n\
apache2-foreground' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
