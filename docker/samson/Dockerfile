FROM zendesk/samson

ENV PATH             /opt/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin/:/app/bin/:/opt/deployment
ENV PYTHONPATH       /opt/ansible/lib
ENV ANSIBLE_LIBRARY  /opt/ansible/library

# Setup samson
ADD config/database.yml /app/config/database.yml
ADD config/samson.conf  /app/.env

# Install additional deployment packages
COPY bin/install.sh  /install.sh
RUN  bash /install.sh

# Deploy ssh configuration/keys
COPY config/ssh/ /root/.ssh/

# Run
COPY bin/entrypoint.sh       /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["samson"]
