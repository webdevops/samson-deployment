#!/bin/bash

trap 'echo sigterm ; exit' SIGTERM
trap 'echo sigkill ; exit' SIGKILL

#############################
## Fix rights
#############################

# Default rights for /root/.ssh
if [ -d /root/.ssh ]; then
    find /root/.ssh/ -type d -print0 | xargs -0 --no-run-if-empty chmod 700
    find /root/.ssh/ -type f -print0 | xargs -0 --no-run-if-empty chmod 600
fi

# Set executable right for deployment
chmod +x /opt/deployment/deploy

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
