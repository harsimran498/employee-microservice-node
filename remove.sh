#!/usr/bin/sh
##Remove all containers using the employee image##
rem = "docker ps -a | grep employee-microservice-nodenpminstall | awk '{print $1}'"
docker rm $rem
