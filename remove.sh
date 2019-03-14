#!/usr/bin/sh
##Remove all containers using the employee image##
docker stop `docker ps -a | grep 8002 | awk '{print $1}'`
docker rm `docker ps -a | grep 8002 | awk '{print $1}'`

