module "iam_for_cw" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.3"

  create_role             = true
  create_instance_profile = false
  role_requires_mfa       = false
  role_name               = format("%s-flowlog-cw-role", var.name)

  trusted_role_services   = ["vpc-flow-logs.amazonaws.com"]
  custom_role_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess"]

  tags = merge(local.tags, { Name = format("%s-flowlog-cw-role", var.name) })
}

module "iam_for_s3" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.3"

  create_role             = true
  create_instance_profile = false
  role_requires_mfa       = false
  role_name               = format("%s-flowlog-s3-role", var.name)

  trusted_role_services   = ["vpc-flow-logs.amazonaws.com"]
  custom_role_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]

  tags = merge(local.tags, { Name = format("%s-flowlog-s3-role", var.name) })
}