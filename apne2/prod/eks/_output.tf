output "workers_asg_arns" {
  value = module.eks.workers_asg_arns
}

output "workers_asg_names" {
  value = module.eks.workers_asg_names
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}