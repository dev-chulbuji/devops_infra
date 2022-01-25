module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name            = local.name
  cidr            = local.cidr
  public_subnets  = local.public_subnets
  azs             = local.azs

  enable_ipv6 = local.enable_ipv6

  enable_nat_gateway = local.enable_nat_gateway

  tags                = local.tags
  public_subnet_tags  = local.public_subnet_tags
  vpc_tags            = local.vpc_tags
}
