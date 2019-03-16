#!/usr/bin/sh

environment=$1
BUILDNO=$2

ansible-playbook -i hosts docker.yml --limit $environment --extra-vars "BUILD=$BUILDNO"
