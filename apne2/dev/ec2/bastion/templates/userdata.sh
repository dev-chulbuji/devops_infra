#!/bin/bash

# install cwagent
sudo yum install -y amazon-cloudwatch-agent

# run agent
sudo amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file://opt/aws/amazon-cloudwatch-agent/bin/config.json \
  -s

# check agent status
amazon-cloudwatch-agent-ctl -m ec2 -a status