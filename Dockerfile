# Use PHP 8.2 FPM
FROM php:8.2-fpm

# Set working directory
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
    chromium \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    fonts-liberation \
    && docker-php-ext-install zip pdo pdo_mysql gd mbstring exif pcntl bcmath sockets

# Set Puppeteer environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Copy project files
COPY . .

# Fix permissions for Laravel storage & cache
RUN mkdir -p storage/framework/cache/data storage/framework/views storage/framework/sessions bootstrap/cache
RUN chmod -R 777 storage bootstrap/cache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHP dependencies (composer)
RUN composer install --no-dev --optimize-autoloader

# Build frontend assets
RUN npm install
RUN npm run build

# Cache Laravel config & routes (Removed to avoid build-time env issues)
# RUN php artisan config:cache
# RUN php artisan route:cache

# Expose port
EXPOSE 8000

# Start Laravel server
CMD php artisan serve --host=0.0.0.0 --port=$PORT
