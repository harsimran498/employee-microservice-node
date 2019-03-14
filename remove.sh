#!/usr/bin/sh
##Remove all containers using the employee image##
docker stop `docker ps -a | grep 8002 | awk '{print $1}'`
docker rm `docker ps -a | grep 8002 | awk '{print $1}'`

if [ $? -eq 0 ]
then
  echo " Process killed running on port 8002 already"
else
  echo " Process not running on port port 8002 "
  exit 0
fi
