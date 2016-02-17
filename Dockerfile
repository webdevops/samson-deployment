FROM webdevops/samson-deployment

# Setup
COPY etc/crontab         /etc/cron.d/samson-deployment
COPY etc/database.yml    /app/config/database.yml
COPY etc/samson.conf     /app/.env
COPY etc/provision.yml   /app/provision.yml
COPY etc/known_hosts/    /root/.known_ssh_prefetched

# Deploy deployment scripts
COPY deployment/      /opt/deployment/

# Deploy ssh configuration/keys
COPY ssh/             /home/application/.ssh/

COPY provision/       /opt/docker/provision/

RUN bash /opt/docker/bin/control.sh provision.role samson-deployment \
    && /opt/docker/bin/control.sh service.enable cron \
    && bash /opt/docker/bin/bootstrap.sh

VOLUME ["/app/cached_repos/", "/tmp"]