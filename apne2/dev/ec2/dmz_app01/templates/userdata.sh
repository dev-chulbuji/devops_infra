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

# workload
wget \
  https://raw.githubusercontent.com/dev-chulbuji/devops_sample_app_python/master/deploy/docker-compose.yml \
  -O /home/ec2-user/docker-compose.yml

ECR_DOCKER_IMAGE="${ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/${DOCKER_IMAGE_NAME}"
ECR_DOCKER_TAG="${DOCKER_IMAGE_TAG}"

aws ecr get-login-password --region ${REGION} \
  | docker login --username AWS --password-stdin $ECR_DOCKER_IMAGE;

export IMAGE=$ECR_DOCKER_IMAGE;
export TAG=$ECR_DOCKER_TAG;
docker-compose -f /home/ec2-user/docker-compose.yml up -d;


