# Use PHP 8.3 with Apache
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Enable Apache mod_rewrite
RUN a2enmod rewrite

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
    && pecl install mongodb && docker-php-ext-enable mongodb

# Copy application files
COPY . .

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Set environment variables (these can be overridden on Render)
ENV APP_URL=https://nocodb-1-orc7.onrender.com
ENV DB_HOST=127.0.0.1
ENV DB_PORT=3306
ENV DB_DATABASE=dreamfactory
ENV DB_USERNAME=root
ENV DB_PASSWORD=rootpassword
ENV DB_ROOT_PASSWORD=rootpassword

# Expose port 80 for Apache
EXPOSE 80

# Start MySQL and Apache together
CMD service mysql start && apache2-foreground
