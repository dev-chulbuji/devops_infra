#!/bin/bash

# install cwagent
sudo yum install -y amazon-cloudwatch-agent

# download config
wget \
  https://raw.githubusercontent.com/dev-chulbuji/devops_infra/master/apne2/dev/ec2/bastion/templates/cloudwatch-agent-config.json \
  -O /opt/aws/amazon-cloudwatch-agent/bin/config.json

# run agent
sudo amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s

# check agent status
amazon-cloudwatch-agent-ctl -m ec2 -a status

# docker
sudo yum update
sudo yum install -y docker git
systemctl enable docker
systemctl start docker
sudo usermod -aG docker ec2-user

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# node-exporter
git clone https://github.com/dev-chulbuji/devops_prometheus.git /home/ec2-user/devops_prometheus
docker network create monitoring
cd /home/ec2-user/devops_prometheus/compose-files/node-exporter
docker-compose up -d

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

# ebs
mkfs -t xfs /dev/sdh
mkdir /docker
mount /dev/sdh /docker