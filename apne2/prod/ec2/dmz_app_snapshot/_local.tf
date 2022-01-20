locals {
  region = var.region

  ec2_name     = format("%s-ec2", var.name)
  role_name    = format("%s-role", var.name)
  ssh_sg_name  = format("%s-ssh-sg", var.name)
  http_sg_name = format("%s-http-sg", var.name)

  target_names     = [for cnt in range(0, var.app_count) : format("%s-%s-ec2", var.name, cnt)]
  target_ebs_names = [for cnt in range(0, var.app_count) : format("%s-%s-ebs", var.name, cnt)]
  tags             = merge(var.tags, { Owner = var.owner, Environment = var.env })

  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  azs               = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id     = data.terraform_remote_state.vpc.outputs.default_security_group_id

  random_num = random_integer.this.result
  az         = element(local.azs, local.random_num)
  subnet     = element(local.public_subnet_ids, local.random_num)

  ami_id               = data.aws_ami.this.id
  ami_owners           = var.ami_owners
  ami_filters          = var.ami_filters
  ebs_snapshot_owners  = var.ebs_snapshot_owners
  ebs_snapshot_filters = var.ebs_snapshot_filters
  instance_type        = var.instance_type
  key_name             = var.key_name

  ssh_sg_description      = var.ssh_sg_description
  ssh_ingress_cidr_blocks = var.ssh_ingress_cidr_blocks
  ssh_ingress_rules       = var.ssh_ingress_rules
  ssh_egress_rules        = var.ssh_egress_rules

  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = var.custom_role_policy_arns
}