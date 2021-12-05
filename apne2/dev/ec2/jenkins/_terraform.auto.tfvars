env   = "dev"
name  = "jenkins"
owner = "dj.kim"
tags  = {}

# AMI
ami_owners = ["amazon"]
ami_filters = [
  {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
]

# EC2
instance_type = "m4.large"
key_name      = "dev"
private_ip    = "10.0.1.140"

# iam
trusted_role_services = ["ec2.amazonaws.com"]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
  "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
]

# http sg
http_sg_description      = "HTTP Security group for Bastion EC2 instance"
http_ingress_cidr_blocks = ["0.0.0.0/0"]
http_ingress_rules       = ["http-8080-tcp"]
http_egress_rules        = ["all-all"]

