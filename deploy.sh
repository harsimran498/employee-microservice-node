#!/usr/bin/sh
su - ec2-user
cd /etc/ansible
ansible-playbook -i hosts docker.yml
