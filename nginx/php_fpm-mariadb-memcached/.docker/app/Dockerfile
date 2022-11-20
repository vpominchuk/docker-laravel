FROM ubuntu:22.04

LABEL maintainer="Vasyl Pominchuk"

ARG NODE_VERSION=${NODE_VERSION:-16}
ARG PHP_VERSION=${PHP_VERSION:-8.1}

WORKDIR /var/www/html

ENV TZ=${TZ:-UTC}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update

RUN apt install -y software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt update

RUN apt upgrade -y

RUN apt install -y php${PHP_VERSION}-fpm php${PHP_VERSION}-cli php${PHP_VERSION}-dev \
    php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-gd \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-imap php${PHP_VERSION}-mysql php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-soap \
    php${PHP_VERSION}-intl php${PHP_VERSION}-readline \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-msgpack php${PHP_VERSION}-igbinary php${PHP_VERSION}-redis php${PHP_VERSION}-swoole \
    php${PHP_VERSION}-memcached php${PHP_VERSION}-pcov php${PHP_VERSION}-xdebug php${PHP_VERSION}-opcache

RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/sbin/php-fpm

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN curl -sLS https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN apt install -y nodejs \
    && npm install -g npm

COPY php.ini /etc/php/${PHP_VERSION}/cli/conf.d/99-app.ini

COPY start.sh /usr/local/bin/start

RUN chmod u+x /usr/local/bin/start

RUN apt -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /run/php/

EXPOSE 9000
CMD ["start"]
