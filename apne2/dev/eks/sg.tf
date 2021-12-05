# sg
module "worker" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.sg_name
  description = local.sg_description
  vpc_id      = local.vpc_id

  ingress_with_cidr_blocks = local.ingress_with_cidr_blocks
  egress_rules        = local.egress_rules

  tags = local.tags
}