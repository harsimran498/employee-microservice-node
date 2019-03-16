#!/usr/bin/sh

environment=$1

cd /etc/ansible
sudo su ec2-user -c 'ansible-playbook -i $environment docker.yml'
