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

# IMDSv1
# curl -XGET http://169.254.169.254/latest/meta-data/iam/info
# curl -XGET http://169.254.169.254/latest/meta-data/iam/security-credentials/dmz-app-prod-role

# IMDSv2
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 900"`
# curl -XGET http://169.254.169.254/latest/meta-data/iam/security-credentials/dmz-app-prod-role