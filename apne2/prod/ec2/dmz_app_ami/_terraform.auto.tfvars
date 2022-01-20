env   = "prod"
name  = "dmz-app-prod-ami"
owner = "dj.kim"
tags  = {}

# AMI
ami_owners = ["self"]
ami_filters = [
  {
    name   = "name"
    values = ["devops_ami_01"]
  }
]

# EC2
app_count           = 1
instance_type       = "t3.micro"
key_name            = "prod"
detailed_monitoring = true
ec2_tags            = { monitoring : true }

# ssh sg
ssh_sg_description      = "SSH Security group for Bastion EC2 instance"
ssh_ingress_cidr_blocks = ["211.106.116.65/32"]
ssh_ingress_rules       = ["ssh-tcp"]
ssh_egress_rules        = ["all-all"]

# iam
trusted_role_services = ["ec2.amazonaws.com"]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
]