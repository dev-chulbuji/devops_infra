provider "aws" {
  region = local.region

  #  assume_role {
  #    role_arn     = "{ASSUMED_ROLE}"
  #    session_name = "{SESSION_NAME}"
  #  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  config_path            = "~/.kube/config"
}
