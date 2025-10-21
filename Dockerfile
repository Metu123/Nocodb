# Base image
FROM php:8.1-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip libpng-dev libonig-dev libxml2-dev \
    libzip-dev zip curl mariadb-client && \
    docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clone DreamFactory
RUN git clone https://github.com/dreamfactorysoftware/dreamfactory.git /var/www/html

WORKDIR /var/www/html

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Hardcoded configuration
RUN echo "APP_ENV=production" > .env && \
    echo "APP_KEY=base64:SomeRandomGeneratedKey123456==" >> .env && \
    echo "APP_DEBUG=false" >> .env && \
    echo "DB_CONNECTION=mysql" >> .env && \
    echo "DB_HOST=your-db-host" >> .env && \
    echo "DB_PORT=3306" >> .env && \
    echo "DB_DATABASE=dreamfactory" >> .env && \
    echo "DB_USERNAME=dreamfactory" >> .env && \
    echo "DB_PASSWORD=password" >> .env && \
    echo "DF_ADMIN_EMAIL=admin@example.com" >> .env && \
    echo "DF_ADMIN_PASSWORD=admin123" >> .env

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Run migrations, setup admin, and start Apache
CMD php artisan migrate --force && \
    php artisan df:setup --email=admin@example.com --password=admin123 && \
    apache2-foreground
