module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.23.0"

  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  vpc_id                          = local.vpc_id
  subnets                         = local.public_subnet_ids
  cluster_endpoint_private_access = local.cluster_endpoint_private_access
  cluster_endpoint_public_access  = local.cluster_endpoint_public_access

  worker_groups_launch_template = local.worker_groups_launch_template
  worker_additional_security_group_ids = []

  tags = merge(local.tags, { Name = local.name })
}