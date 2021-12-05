# http sg
module "http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.sg_name
  description = local.sg_name
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = local.http_ingress_cidr_blocks
  ingress_rules       = local.http_ingress_rules
  egress_rules        = local.http_egress_rules

  tags = local.tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name               = local.lb_name
  load_balancer_type = "application"

  vpc_id             = local.vpc_id
  security_groups    = [module.http.security_group_id, local.default_sg_id]
  subnets            = local.public_subnet_ids
  http_tcp_listeners = local.http_tcp_listeners
  #  http_tcp_listener_rules = local.http_tcp_listener_rules
  #  target_groups           = local.target_groups

  tags = local.tags
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = local.eks_workers_asg_names
  elb                    = module.alb.lb_id
}