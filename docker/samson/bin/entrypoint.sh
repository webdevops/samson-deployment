#!/bin/bash

trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL

#############################
## COMMAND
#############################

if [ "$1" = 'samson' ]; then
    while true; do
        echo "(Re-)Starting Samson"
        cd /app/
        bin/rake db:migrate RAILS_ENV=development
        bundle exec puma -C ./config/puma.rb
        sleep 5
    done
fi

exec "$@"
