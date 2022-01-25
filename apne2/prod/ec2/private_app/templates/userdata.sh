#!/bin/bash

# add default user
groupadd -g 1001 devops
useradd -m -g 1001 devops

cd /etc/sudoers.d
echo "#User rules for ssm-user" > ssm-agent-users
echo "devops ALL=(ALL) NOPASSWD:ALL" > ssm-agent-users

mkdir /home/devops/.ssh
cp /home/ec2-user/.ssh/authorized_keys /home/devops/.ssh/authorized_keys

chmod 700 /home/devops/.ssh
chmod 644 /home/devops/.ssh/authorized_keys
chown -R devops:devops /home/devops/.ssh