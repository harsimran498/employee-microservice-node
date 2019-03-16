#!/usr/bin/sh

environment=$1

ansible-playbook -i hosts docker.yml --limit $ENV
