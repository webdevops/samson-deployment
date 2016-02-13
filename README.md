# Samson based deployment server

Deployment web ui with Ansible Ansistrano support with MySQL backend

* [Samson deployment web ui](https://github.com/zendesk/samson)
* [Ansible Ansistrano](https://github.com/ansistrano)


## Setup

* [Generate GitHub appliation key](https://github.com/settings/developers)
* [Generate GitHub access token](https://github.com/settings/tokens)
* Edit `conf/samson.conf` (setup GitHub application key and access token)
* Add ssh keys to `ssh` (will be deployed to `/home/application/.ssh`)
* Run `docker-compose up -d`



## Easy common deployment

For an easy project independed deployment you can use the predefined deployment runner (based on Ansistrano).

Use following as deployment command:

```
export DEPLOYMENT_INVENTORY=vagrant
export DEPLOYMENT_DEPLOY_TO=/var/www/target-deployment-path
/opt/deployment/deploy
```


### Deploy variables

Variable                    | Description
--------------------------- | ------------------------------------------------------
DEPLOYMENT_INVENTORY        | Inventory file for deployment **(required)**
DEPLOYMENT_DEPLOY_TO        | Target deployment directory **(required)**
DEPLOYMENT_SHARED_PATHS     | Shared paths which will be linked after deployment
DEPLOYMENT_CURRENT_DIR      | Link name of the htdocs path (default: current)


### Customization

Variable                    | Description
--------------------------- | ------------------------------------------------------
Ansible inventory           | [deployment/inventory](deployment/inventory)
Common project build task   | [deployment/tasks/build.yml](deployment/tasks/build.yml)
Main deploy playbook        | [deployment/deploy.yml](deployment/deploy.yml)
Common rsync excludes       | [deployment/rsync-excludes](deployment/rsync-excludes)


## Project specific deployment

If you need a project specific deployment feel free to put your ansistrano deployment within your project sources.
Your deployment task should look like:

ansible-playbook -i inventory/server deploy.yml

## Installed packages
* Ansible with Ansistrano
* git
* rsync
* docker & docker-compose (as client)
* gulp, grunt, bower
* php cli & composer