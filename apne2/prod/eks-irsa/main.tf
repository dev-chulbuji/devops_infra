resource "aws_iam_role" "this" {
  count = length(var.serviceAccounts)
  name  = format("%s-role", var.serviceAccounts[count.index].name)
  tags  = merge(var.tags, { Name : format("%s-role", var.serviceAccounts[count.index].name) })
  assume_role_policy = jsonencode({
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRoleWithWebIdentity"
      Principal = {
        Federated = local.eks_oidc_arn
      }
      Condition = {
        StringEquals = {
          format("%s:sub", local.eks_cluster_oidc_issuer_url) = local.oidc_fully_qualified_subjects[count.index]
          format("%s:aud", local.eks_cluster_oidc_issuer_url) = "sts.amazonaws.com"
        }
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(local.attachment_poilicies)
  policy_arn = local.attachment_poilicies[count.index].arn
  role       = aws_iam_role.this[local.attachment_poilicies[count.index].index].name
}