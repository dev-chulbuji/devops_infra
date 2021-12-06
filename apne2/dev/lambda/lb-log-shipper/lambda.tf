module "lambda" {
  source       = "../../../../modules/lambda"
  name         = local.name
  handler      = var.handler
  source_path  = "dist.zip"
  runtime      = var.runtime
  timeout      = var.timeout
  environments = local.envs
  role_arn     = aws_iam_role.this.arn

  tags         = merge(local.tags, { Name = format("%s-lambda", var.name) })
}