ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent
.PHONY: backup restore

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

restart: rebuild

start:
	docker-compose up -d

stop:
	docker-compose stop

log:
	docker-compose logs

rebuild:
	docker-compose build
	docker-compose up -d --force-recreate

update:
	docker pull webdevops/samson-deployment
	docker-compose build
	docker-compose up -d --force-recreate

backup:
	rm -rf ./backup/db/
	docker exec -it -u root $$(docker-compose ps -q app) service samson stop
	docker cp $$(docker-compose ps -q app):/storage/db/ ./backup/db/
	docker exec -it -u root $$(docker-compose ps -q app) service samson start

restore:
	docker exec -it -u root $$(docker-compose ps -q app) service samson stop
	docker exec -it -u root $$(docker-compose ps -q app) rm -rf /storage/db/
	docker cp ./backup/db/ $$(docker-compose ps -q app):/storage/db/
	docker exec -it -u root $$(docker-compose ps -q app) chown -R application:application /storage/db/
	docker exec -it -u root $$(docker-compose ps -q app) service samson start

shell:
	docker exec -it -u application $$(docker-compose ps -q app) /bin/bash

root:
	docker exec -it -u root $$(docker-compose ps -q app) /bin/bash

ssh-key:
	if [ ! -f "./ssh/id_rsa" ]; then \
		echo "Generating ssh key, will take some time ..."; \
		ssh-keygen -b 6144 -N "" -C "Samson deployment service" -f "./ssh/id_rsa"; \
	else \
		echo ""; \
		echo "[ERROR] SSH key already exists!"; \
		echo ""; \
		exit 1; \
	fi

doc-watch:
	docker run -t -i --rm -p 8080:8000 -v "$$(pwd)/documentation/docs/:/opt/docs" webdevops/sphinx sphinx-autobuild --poll -H 0.0.0.0 /opt/docs html
