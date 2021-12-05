locals {
  region = var.region
  tags   = merge(var.tags, { Owner = var.owner, Environment = var.env })

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id      = data.terraform_remote_state.vpc.outputs.default_security_group_id

  name        = format("%s", var.name)
  worker_name = format("worker")
  role_name   = format("%s-eks-worker-role", var.name)
  policy_name = format("%s-eks-worker-policy", var.name)

  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  worker_groups_launch_template = [
    {
      name                 = local.worker_name
      instance_type        = var.worker_instance_type
      asg_desired_capacity = var.worker_instance_count
      public_ip            = var.worker_instance_public_ip
      iam_role_id          = module.iam.iam_role_name
      key_name             = "dev"
      tags = [{
        key                 = "ExtraTag"
        value               = "TagValue"
        propagate_at_launch = true
      }]
    }
  ]

  sg_name        = format("%s-eks-worker-sg", var.name)
  sg_description = format("%s-eks-worker-sg", var.name)

  egress_rules = ["all-all"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 30800
      to_port     = 30800
      protocol    = "tcp"
      description = "argocd nodeport"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = concat(var.custom_role_policy_arns, [aws_iam_policy.this.arn])
}