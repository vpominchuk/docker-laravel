# docker-laravel

Is a set of docker-compose configurations to run Laravel Application under docker.

At the moment it includes two configurations:
- Apache2 + mod_php8.1 + mariadb + memcached
- Nginx + php-fpm8.1 + mariadb + memcached

In addition to this all configurations also include `adminer` container which can help you to manage your database.
By default `adminer` is available by this link: http://localhost:8080. You can change default port in your `.env` file by setting up `ADMINER_PORT=8080` variable.

Please check `.env.example` file for more configuration options.

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

## Queue control
You can configure your queue behavior changing following variables:


| Variable | Description |
|----------|-------------|
| `APP_ENV=local` | Queue workers are long-lived processes and store the booted application state in memory. As a result, they will not notice changes in your code base after they have been started. So, during your deployment process, be sure to setup `APP_ENV=local`. This setting tells container to run `queue:listen` instead of `queue:work` command. |
| `QUEUE=default` | By setting this variable you can tell container to process specific queues. In this case the `php artisan queue:work --queue=default` command will be started. You can specify number of queues at the same time `QUEUE=default,high,emails`


