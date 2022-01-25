resource "aws_cloudwatch_log_group" "accept" {
  name              = format("/aws/vpc/flowlog/accept/%s", var.name)
  retention_in_days = var.vpc_flow_retention_days
  tags              = merge(var.tags, { Name = format("/aws/vpc/flowlog/accept/%s", var.name) })
}

resource "aws_cloudwatch_log_group" "reject" {
  name              = format("/aws/vpc/flowlog/reject/%s", var.name)
  retention_in_days = var.vpc_flow_retention_days
  tags              = merge(var.tags, { Name = format("/aws/vpc/flowlog/reject/%s", var.name) })
}