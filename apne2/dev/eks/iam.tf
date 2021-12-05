# iam
module "iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.3"

  create_role             = true
  create_instance_profile = false
  role_name               = local.role_name
  role_requires_mfa       = false

  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = local.custom_role_policy_arns
}

resource "aws_iam_policy" "this" {
  name        = local.policy_name
  description = local.policy_name
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = var.additional_policy_actions
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}