# Use PHP 8.3 with Apache
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    default-mysql-server \
    ftp \
    && docker-php-ext-install pdo_mysql zip exif pcntl gd bcmath sockets \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb

# Enable Apache rewrite module
RUN a2enmod rewrite

# Create composer.json inside container
RUN cat << 'EOF' > composer.json
{
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
            "App\\": "app/"
        }
    }
}
EOF

# Create .env inside container
RUN cat << 'EOF' > .env
APP_NAME=DreamFactory
APP_ENV=production
APP_KEY=base64:RandomKeyHere
APP_DEBUG=false
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=dreamfactory
DB_USERNAME=root
DB_PASSWORD=

CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync
EOF

# Install Composer and project dependencies
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Copy your app source code
COPY . .

# Expose port 80
EXPOSE 80

# Start Apache and MySQL together
CMD service mysql start && apache2-foreground
