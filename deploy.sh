#!/usr/bin/sh

environment=$1

cd /etc/ansible
ansible-playbook -i $environment docker.yml
