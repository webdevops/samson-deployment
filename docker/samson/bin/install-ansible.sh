#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

if [ ! -d '/opt/ansible/' ]; then
    apt-get update -q
    apt-get install -y python-crypto python-httplib2 python-jinja2 python-markupsafe python-paramiko python-selinux python-yaml
    apt-get install -y python-pip git aptitude
    pip install ansible

    rm -rf /var/lib/apt/lists/*
    apt-get clean -y
fi

# Ansistratno
ansible-galaxy install --force carlosbuenosvinos.ansistrano-deploy carlosbuenosvinos.ansistrano-rollback
