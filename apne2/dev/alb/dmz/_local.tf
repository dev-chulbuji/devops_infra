locals {
  region = var.region

  name              = format("%s-alb", var.name)
  http_sg_name      = format("%s-http-sg", var.name)
  target_group_name = "tg-"

  tags = merge(var.tags, { Owner = var.owner, Environment = var.env })

  # remote
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id      = data.terraform_remote_state.vpc.outputs.default_security_group_id
  target_id         = data.terraform_remote_state.target.outputs.id

  # sg
  http_sg_description      = var.http_sg_description
  http_ingress_cidr_blocks = var.http_ingress_cidr_blocks
  http_ingress_rules       = var.http_ingress_rules
  http_egress_rules        = var.http_egress_rules

  # alb
  http_tcp_listeners      = var.http_tcp_listeners
  http_tcp_listener_rules = var.http_tcp_listener_rules
  target_groups = [
    {
      name_prefix      = local.target_group_name
      backend_protocol = var.backend_protocol
      backend_port     = var.backend_port
      target_type      = var.target_type
      targets = {
        jenkins = {
          target_id = local.target_id
          port      = var.backend_port
        }
      }
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.health_check_url
        port                = var.backend_port
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = local.tags
    }
  ]
}