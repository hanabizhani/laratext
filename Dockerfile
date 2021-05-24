FROM php:8.0-apache


RUN apt-get clean
RUN apt-get update
RUN apt-get install -y tesseract-ocr
RUN apt-get install -y tesseract-ocr-fas
RUN apt-get install -y apache2 && apt-get clean
RUN docker-php-ext-install pcntl

RUN apt-get install -y zip libzip-dev
RUN docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --version=2.0.9 --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html
COPY . /app/laratext
WORKDIR /app/laratext

RUN composer install

ENTRYPOINT ["php", "artisan" ,"laratext:convert"]
