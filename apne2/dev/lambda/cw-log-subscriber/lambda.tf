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

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  principal     = "logs.${var.region}.amazonaws.com"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  source_arn    = "arn:aws:events:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:${var.log_group_name}:*"
}