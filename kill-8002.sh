#!/usr/bin/sh
netstat -ltnp | grep -w ':8002' | awk -F "LISTEN" '{print $2}'|  awk -F "/" '{print $1}' |  xargs kill -9 &> /dev/null
if [ $? -eq 0 ]
then
  echo " Process killed running on port 8002 already"
else
  echo " Process not running on port port 8002 "
  exit 0
fi
