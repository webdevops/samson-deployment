# Samson based deployment server

Deployment web ui with Ansible Ansistrano support with MySQL backend

* [Samson deployment web ui](https://github.com/zendesk/samson)
* [Ansible Ansistrano](https://github.com/ansistrano)


## Setup

* Edit `docker/samson/config/samson.conf` (setup GitHub credentials)
* Add ssh keys to `samson/ssh` (will be deployed to `/root/.ssh`)
* Run `docker-compose up -d`



## Easy deployment

For an easy project independed deployment you can use the predefined deployment runner (based on Ansistrano).

Use following as deployment command:

```
export DEPLOYMENT_INVENTORY=vagrant
export DEPLOYMENT_TARGET=/var/www/target-deployment-path/
/opt/deployment/deploy
```