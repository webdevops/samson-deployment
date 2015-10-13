FROM zendesk/samson

ADD config/database.yml /app/config/database.yml
ADD config/samson.conf  /app/.env

COPY bin/entrypoint.sh  /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["samson"]
