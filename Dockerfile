FROM webdevops/samson-deployment

# Setup
ADD etc/crontab         /etc/cron.d/samson-deployment
ADD etc/database.yml    /app/config/database.yml
ADD etc/samson.conf     /app/.env
ADD etc/provision.yml   /app/provision.yml

# Deploy deployment scripts
COPY deployment/      /opt/deployment/

# Deploy ssh configuration/keys
COPY ssh/             /home/application/.ssh/

COPY provision/       /opt/docker/provision/
RUN bash /opt/docker/bin/control.sh provision.role samson-deployment \
    && bash /opt/docker/bin/control.sh provision.role.finish samson-deployment \
    && /opt/docker/bin/control.sh service.enable cron \
    && bash /opt/docker/bin/bootstrap.sh

VOLUME ["/app/cached_repos/", "/tmp"]