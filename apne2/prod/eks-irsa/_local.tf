locals {
  region = var.region
  tags   = merge(var.tags, { Owner = var.owner, Environment = var.env })

  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  azs                = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id      = data.terraform_remote_state.vpc.outputs.default_security_group_id

  eks_oidc_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  eks_cluster_oidc_issuer_url = replace(data.terraform_remote_state.eks.outputs.cluster_oidc_issuer_url, "https://", "")

  oidc_fully_qualified_subjects = [for each in var.serviceAccounts : format("system:serviceaccount:%s:%s", each.namespace, each.name)]

  attachment_poilicies = flatten([
    for i,v in var.serviceAccounts : [
      for each in v.policy_arns : {
        index   = i
        arn = each
      }
    ]
  ])
}