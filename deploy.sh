#!/usr/bin/sh

cd /etc/ansible
sudo su ec2-user -c 'ansible-playbook -i $ENV docker.yml'
