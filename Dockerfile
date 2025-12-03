# PHP 8.2 FPM
FROM php:8.2-fpm

WORKDIR /var/www

# Install system dependencies + PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    nodejs \
    npm \
    && docker-php-ext-install zip pdo pdo_mysql gd mbstring exif pcntl bcmath sockets

# Copy project
COPY . .

# Fix permissions
RUN mkdir -p storage/framework/cache/data bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHP dependencies (with scripts)
RUN composer install --no-dev --optimize-autoloader

# Build frontend
RUN npm install
RUN npm run build

# Cache Laravel
RUN php artisan config:cache
RUN php artisan route:cache

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=$PORT
