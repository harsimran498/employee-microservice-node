#!/usr/bin/sh
chmod 777 deploy.sh
su - ec2-user
cd /etc/ansible
ansible-playbook -i hosts docker.yml
