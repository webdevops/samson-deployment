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
	docker-compose up -d

fix-restart:
	docker-compose stop
	docker-compose rm --force main
	docker-compose build --no-cache main
	docker-compose up -d
