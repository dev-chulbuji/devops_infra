locals {
  region = var.region
  tags   = merge(var.tags, { Owner = var.owner, Environment = var.env })

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id      = data.terraform_remote_state.vpc.outputs.default_security_group_id

  name        = format("%s-opensearch", var.name)
  es_version     = var.es_version
  instance_type  = var.instance_type
  instance_count = var.instance_count
}