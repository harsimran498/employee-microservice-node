#!/usr/bin/sh
##Remove all containers using the employee image##
docker rm $(docker ps -a | grep employee-microservice-nodenpminstall | awk '{print $1}')
