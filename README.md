# Samson based deployment server

[ZenDesk's](https://www.zendesk.com/) Deployment web ui with Ansible Ansistrano, Capistrano and PHP Deployer support

Installed packages:
* [Samson deployment web ui](https://github.com/zendesk/samson)
* [Ansible](https://www.ansible.com/) with [Ansistrano](https://github.com/ansistrano)
* [Capistrano](http://capistranorb.com/)
* [PHP Deployer](http://deployer.org/)
* git
* rsync
* docker & docker-compose (as client)
* gulp, grunt, bower
* PHP cli & [composer](https://getcomposer.org/)

### What?
(from [ZenDesk/Samson repository](https://github.com/zendesk/samson))

A web interface for deployments.

**View the current status of all your projects:**

![](http://f.cl.ly/items/3n0f0m3j2Q242Y1k311O/Samson.png)

**Allow anyone to watch deploys as they happen:**

![](http://cl.ly/image/1m0Q1k2r1M32/Master_deploy__succeeded_.png)

**View all recent deploys across all projects:**

![](http://cl.ly/image/270l1e3s2e1p/Samson.png)

## Setup

* [Generate GitHub appliation key](https://github.com/settings/developers) 
* [Generate GitHub access token](https://github.com/settings/tokens)
* Edit `conf/samson.conf`:
    * Set GitHub appliation credentials (`GITHUB_CLIENT_ID`, `GITHUB_SECRET`)
    * Set GitHub access token (`GITHUB_TOKEN`)
    * Set `SECRET_TOKEN` (random string with length of 128, can be generated with `openssl rand -hex 128| head -c 128`)
    * Set `DEFAULT_URL` (must be accessable url for SSO callbacks)
* Edit `etc/provision.yml` to setup public key fetching of `.ssh/known_hosts`
    * Fixed known_host keys can be stored inside `etc/known_hosts` folder and can be generated with `ssh-keyscan -H HOSTNAME > etc/known_hosts/HOSTNAME` (very secure)
    * All hosts without stored known_host keys will be automatically fetched when Dockerfile build is running (less secure)
* Add ssh keys to `ssh` (will be deployed to `/home/application/.ssh`) or generate an new one with `make ssh-key`
* Run `docker-compose up -d` or `make restart`

## Ansistrano deployment

For an easy project independed deployment you can use the predefined deployment runner (based on Ansistrano).

Use following as deployment command:

```
export DEPLOYMENT_INVENTORY=vagrant
export DEPLOYMENT_DEPLOY_TO=/var/www/target-deployment-path
/opt/ansistrano/deploy
```

### Deploy variables

Variable                       | Description
------------------------------ | ------------------------------------------------------
DEPLOYMENT_INVENTORY           | Inventory file for deployment **(required)**
DEPLOYMENT_DEPLOY_TO           | Target deployment directory **(required)**
DEPLOYMENT_CURRENT_DIR         | Link name of the htdocs path (default: current)
DEPLOYMENT_APPLICATION         | Include variables for specific application (eg. for shared paths, eg `typo3` for including `deployment/applications/typo3.yml`)
DEPLOYMENT_PROJECT             | Include variables for specific project (eg. for shared paths, eg `foobar` for including `deployment/projects/foobar.yml`)
DEPLOYMENT_OPTS                | Ansible options (can also be append to `/opt/ansistrano/deploy`)
DEPLOYMENT_PLAYBOOK            | Ansible playbook (default is `deploy`)
DEPLOYMENT_URL                 | URL to website (required for eg. PHP opcode cache clearing)

### Customization

Variable                    | Description
--------------------------- | ------------------------------------------------------
Ansible inventory           | [deployment/inventory](ansistrano/inventory)
Common project build task   | [deployment/tasks/build.yml](ansistrano/tasks/build.yml)
Main deploy playbook        | [deployment/deploy.yml](ansistrano/deploy.yml)
Common rsync excludes       | [deployment/rsync-excludes](ansistrano/rsync-excludes)

## PHP deployer
Use following as deployment command:

```
dep deploy
```

## Makefile

Command                     | Description
--------------------------- | ------------------------------------------------------
`make restart`              | Restart Samson (and update/deploy configuration)
`make start`                | Start Samson
`make stop`                 | Stop Samson
`make log`                  | Show logs
`make update`               | Update Samson docker image (`docker pull`) and restart Samson
`make ssh-key`              | Generate new ssh-key (will not overwrite if exists)
`make shell`                | Jump into shell inside the container (as `application` user)
`make root`                 | Jump into shell inside the container (as `root` user)

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
    ProxyCommand ssh ssh-gateway -W %h:%p
```

Now you can use `server-behind-gateway` as target host for SSH'ing at it will automatically jump over `ssh-gateway` to
reach this server.
