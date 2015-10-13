FROM zendesk/samson

ENV PATH             /opt/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin/:/app/bin/
ENV PYTHONPATH       /opt/ansible/lib
ENV ANSIBLE_LIBRARY  /opt/ansible/library

ADD config/database.yml /app/config/database.yml
ADD config/samson.conf  /app/.env

COPY bin/install-ansible.sh  /install-ansible.sh
RUN  bash /install-ansible.sh

COPY bin/entrypoint.sh       /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["samson"]
