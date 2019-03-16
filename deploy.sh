#!/usr/bin/sh

environment=$1
BUILDNO=$2

ansible-playbook -i hosts sample.yml --limit $environment -e "build=Dev.82"
