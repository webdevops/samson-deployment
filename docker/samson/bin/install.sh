#!/usr/bin/env bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

apt-get update -q

if [ ! -d '/opt/ansible/' ]; then
    apt-get install -y \
        python-crypto \
        python-httplib2 \
        python-jinja2 \
        python-markupsafe \
        python-paramiko \
        python-selinux \
        python-yaml \
        python-pip
    pip install ansible
fi

# Default deployment tools
apt-get install -y \
    sshpass \
    git \
    rsync

# Ansistratno
ansible-galaxy install --force carlosbuenosvinos.ansistrano-deploy carlosbuenosvinos.ansistrano-rollback


# Cleanup
rm -rf /var/lib/apt/lists/*
apt-get clean -y
