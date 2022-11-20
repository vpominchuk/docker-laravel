# docker-laravel

Is a set of docker-compose configurations to run Laravel Application under docker.

At the moment it includes two configurations:
- Apache2 + mod_php8.1 + mariadb + memcached
- Nginx + php-fpm8.1 + mariadb + memcached

Please check `.env.example` file for configuration options.

## How to use

`git clone https://github.com/vpominchuk/docker-laravel.git`

1. Copy `docker-compose.yml` and `.docker` folder to your Laravel root folder.
2. Copy configuration options from `.env.example` to your Laravel `.env` file
3. Run `docker-compose up -d`

## Laravel scheduler and queue

An image with PHP is a multipurpose image, 
that means it used to serve your Laravel code together with a Web server
and can be used to process with Laravel Scheduler and Queue.

There is an environment variable `CONTAINER_ROLE` that may be `app`, `queue`, `scheduler`.
- To run Laravel Scheduler there is a container named `scheduler` with `CONTAINER_ROLE=scheduler`
- To run Laravel Queue  there is a container named `scheduler` with `CONTAINER_ROLE=queue`

