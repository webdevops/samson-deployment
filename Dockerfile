FROM webdevops/samson-deployment

ENV RAILS_ENV="production"
ENV PYTHONUNBUFFERED=1

# Setup
COPY etc/crontab         /etc/cron.d/samson-deployment
COPY etc/database.yml    /app/config/database.yml
COPY etc/samson.conf     /app/.env
COPY etc/provision.yml   /app/provision.yml
COPY etc/known_hosts/    /root/.known_ssh_prefetched

# Deploy ansistrano scripts
COPY ansistrano/      /opt/ansistrano/

# Deploy ssh configuration/keys
COPY ssh/             /home/application/.ssh/

COPY provision/       /opt/docker/provision/

RUN /opt/docker/bin/provision run --tag build --role samson-deployment \
    && /opt/docker/bin/control.sh service.enable cron \
    && /opt/docker/bin/bootstrap.sh

# Enable Docker daemon
# --> Also requies privileged mode in docker-compose.yml
#RUN /opt/docker/bin/control.sh service.enable docker

VOLUME ["/tmp", "/storage", "/var/lib/docker"]
