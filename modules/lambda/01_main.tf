resource "aws_lambda_function" "this" {
  function_name = var.name
  filename      = var.source_path
  memory_size   = var.memory_size

  handler = var.handler
  runtime = var.runtime

  role    = var.role_arn
  timeout = var.timeout

  source_code_hash = filebase64sha256(var.source_path)

  dynamic "environment" {
    for_each = length(keys(var.environments)) == 0 ? [] : [var.environments]
    content {
      variables = environment.value
    }
  }

  depends_on = [
    aws_cloudwatch_log_group.this
  ]

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention_in_days
}
