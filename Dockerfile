FROM php:7.3.6-fpm-alpine3.9

ENV DOCKERIZE_VERSION v0.6.1

RUN apk add --no-cache shadow bash mysql-client --no-cache openssl && \
    docker-php-ext-install pdo pdo_mysql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -rf /var/www/html

# COPY . /var/www
RUN chown -R www-data:www-data /var/www && \
    usermod -u 1000 www-data

USER www-data

#RUN ls -s public html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
