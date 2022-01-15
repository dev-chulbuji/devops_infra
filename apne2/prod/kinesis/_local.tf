locals {
  region = var.region
  tags   = merge(var.tags, { Owner = var.owner, Environment = var.env })

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id      = data.terraform_remote_state.vpc.outputs.default_security_group_id
  es_arn             = data.terraform_remote_state.es.outputs.arn

  kinesis_stream_name          = format("%s-stream", var.name)
  kinesis_delivery_stream_name = format("%s-delivery-stream", var.name)
  s3_name                      = format("%s-s3", var.name)
  iam_role_name                = format("%s-role", var.name)
  iam_policy_name              = format("%s-policy", var.name)

  # IAM
  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = concat(var.custom_role_policy_arns, aws_iam_policy.this.*.arn)
}