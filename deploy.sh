#!/usr/bin/sh

su - ec2-user
id
cd /etc/ansible
ansible-playbook -i hosts docker.yml
