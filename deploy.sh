#!/usr/bin/sh


id
cd /etc/ansible
sudo su ec2-user -c 'ansible-playbook -i hosts docker.yml'
