#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-app}
app_env=${APP_ENV:-local}
queue=${QUEUE:-default}

if [ "$role" = "app" ]; then
    exec php-fpm -F -R
elif [ "$role" = "queue" ]; then
    echo "Starting queue: $queue"

    if [ "$app_env" = "local" ]; then
        echo "Local environment: start listening"
        php artisan queue:listen --verbose --tries=3 --timeout=90 --queue="$queue"
    else
        php artisan queue:work --verbose --tries=3 --timeout=90 --queue="$queue"
    fi
elif [ "$role" = "scheduler" ]; then
    while [ true ]
    do
      php artisan schedule:run --verbose --no-interaction & sleep 60
    done
else
    echo "Could not match the container role \"$role\""
    exit 1
fi
