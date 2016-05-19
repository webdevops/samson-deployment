==========
Deployment
==========

Requirements
------------

* SSH connection to server (added public key to ``~/.ssh/authorized_keys`` on target host)
* Rsync on target server


Ansistrano
----------

Inventory
^^^^^^^^^

The inventory for ansistrano is found inside the ``ansistrano/inventory/`` directory and can be setup as a normal
`Ansible inventory`_.

Samson project setup
--------------------

Add project
^^^^^^^^^^^

Add a git based project to Samson:

.. figure:: /resources/images/samson-create-project-01.png

.. figure:: /resources/images/samson-create-project-02.png

.. figure:: /resources/images/samson-create-project-03.png

For Ansistrano deployment use following example:

.. code-block:: bash

    export DEPLOYMENT_INVENTORY=vagrant
    export DEPLOYMENT_DEPLOY_TO=/var/www/target-deployment-path
    export DEPLOYMENT_APPLICATION="typo3"
    export TYPO3_CONTEXT="Production"
    /opt/ansistrano/deploy



.. _Ansible inventory: http://docs.ansible.com/ansible/intro_inventory.html
