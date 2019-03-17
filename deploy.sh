#!/usr/bin/sh

environment=$1
BUILDNO=$2
user=$3
password=$4

ansible-playbook -i hosts docker.yml --limit $environment -e "build=$BUILDNO user=$user password=$password"
