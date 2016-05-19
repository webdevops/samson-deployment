=====
Usage
=====

Makefile targets
----------------

============================  ==========================================================================================
Makefile target               Description
============================  ==========================================================================================
``make restart``              Restart Samson (and update/deploy configuration)
``make start``                Start Samson
``make stop``                 Stop Samson
``make log``                  Show logs
``make update``               Update Samson docker image (``docker pull``) and restart Samson
``make ssh-key``              Generate new ssh-key (will not overwrite if exists)
|
``make backup``               Run backup (app:/app/db/ will be copied to ./backup/db/)

``make restore``              Run restore (./backup/db/ will be copied to app:/app/db/)
|
``make shell``                Jump into shell inside the container (as ``application`` user)

``make root``                 Jump into shell inside the container (as ``root`` user)
|
``make documentation``        Run sphinx container and render documentation on port 8080 (on docker host)
============================  ==========================================================================================
