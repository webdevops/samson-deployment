# Samson based deployment server

Deployment web ui with Ansible Ansistrano support with MySQL backend

* [Samson deployment web ui](https://github.com/zendesk/samson)
* [Ansible Ansistrano](https://github.com/ansistrano)


## Setup

* Edit `conf/samson.conf` (setup GitHub credentials)
* Add ssh keys to `ssh` (will be deployed to `/root/.ssh`)
* Run `docker-compose up -d`



## Easy common deployment

For an easy project independed deployment you can use the predefined deployment runner (based on Ansistrano).

Use following as deployment command:

```
export DEPLOYMENT_INVENTORY=vagrant
export ANSISTRANO_DEPLOY_TO=/var/www/target-deployment-path/
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
Ansible inventory           | [samson/deployment/inventory](samson/deployment/inventory)
Common project build task   | [samson/deployment/tasks/build.yml](samson/deployment/tasks/build.yml)
Main deploy playbook        | [samson/deployment/deploy.yml](samson/deployment/deploy.yml)
Common rsync excludes       | [samson/deployment/rsync-excludes](samson/deployment/rsync-excludes)


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