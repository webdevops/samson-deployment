FROM webdevops/samson-deployment

# Setup samson
ADD conf/database.yml /app/config/database.yml
ADD conf/samson.conf  /app/.env

# Deploy deployment scripts
COPY deployment/      /opt/deployment/

# Deploy ssh configuration/keys
COPY ssh/             /root/.ssh/

