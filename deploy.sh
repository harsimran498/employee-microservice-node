#!/usr/bin/sh

environment=$1

ansible-playbook -i $environment docker.yml
