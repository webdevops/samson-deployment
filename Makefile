ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

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
