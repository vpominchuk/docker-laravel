#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-app}

if [ "$role" = "app" ]; then
    exec /usr/sbin/apache2ctl -D FOREGROUND
elif [ "$role" = "queue" ]; then
    php artisan queue:work --verbose --tries=3 --timeout=90
elif [ "$role" = "scheduler" ]; then
    while [ true ]
    do
      php artisan schedule:run --verbose --no-interaction & sleep 60
    done
else
    echo "Could not match the container role \"$role\""
    exit 1
fi
