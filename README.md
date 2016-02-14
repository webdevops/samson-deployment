# Samson based deployment server

Deployment web ui with Ansible Ansistrano and PHP Deployer support with MySQL backend

Installed packages:
* [Samson deployment web ui](https://github.com/zendesk/samson)
* [Ansible](https://www.ansible.com/) with [Ansistrano](https://github.com/ansistrano)
* [PHP Deployer](http://deployer.org/)
* git
* rsync
* docker & docker-compose (as client)
* gulp, grunt, bower
* PHP cli & [composer](https://getcomposer.org/)

## Setup

* [Generate GitHub appliation key](https://github.com/settings/developers) 
* [Generate GitHub access token](https://github.com/settings/tokens)
* Edit `conf/samson.conf` (setup GitHub credentials, SECRET_TOKEN and DEFAULT_URL)
* Add ssh keys to `ssh` (will be deployed to `/home/application/.ssh`)
* Run `docker-compose up -d`



## Ansistrano deployment

For an easy project independed deployment you can use the predefined deployment runner (based on Ansistrano).

Use following as deployment command:

```
export DEPLOYMENT_INVENTORY=vagrant
export DEPLOYMENT_DEPLOY_TO=/var/www/target-deployment-path
/opt/deployment/deploy
```

### Deploy variables

Variable                       | Description
------------------------------ | ------------------------------------------------------
DEPLOYMENT_INVENTORY           | Inventory file for deployment **(required)**
DEPLOYMENT_DEPLOY_TO           | Target deployment directory **(required)**
DEPLOYMENT_CURRENT_DIR         | Link name of the htdocs path (default: current)
DEPLOYMENT_APPLICATION         | Include variables for application (eg. for shared paths, eg `typo3` for including `deployment/applications/typo3.yml`)
DEPLOYMENT_OPTS                | Ansible options (can also be append to `/opt/deployment/deploy`)
DEPLOYMENT_PLAYBOOK            | Ansible playbook (default is `deploy`)

### Customization

Variable                    | Description
--------------------------- | ------------------------------------------------------
Ansible inventory           | [deployment/inventory](deployment/inventory)
Common project build task   | [deployment/tasks/build.yml](deployment/tasks/build.yml)
Main deploy playbook        | [deployment/deploy.yml](deployment/deploy.yml)
Common rsync excludes       | [deployment/rsync-excludes](deployment/rsync-excludes)

## PHP deployer
Use following as deployment command:

```
dep deploy
```


## Project specific deployment

If you need a project specific deployment feel free to put your ansistrano deployment within your project sources.
Your deployment task should look like:

ansible-playbook -i inventory/server deploy.yml

## SSH - jump to servers behind gateways transparently

With ssh you can jump over multiple servers transparently to reach servers behinde ssh gateways, use the `ssh/config` 
file for configuration:

```
Host ssh-gateway
    Hostname ssh-gateway.example.com
    User foo

Host server-behind-gateway
    Hostname server-behind-ssh-gateway.example.com
    User     root
    ProxyCommand ssh ssh--server -W %h:%p
```

Now you can use `server-behind-gateway` as target host for SSH'ing at it will automatically jump over `ssh-gateway` to
reach this server.
