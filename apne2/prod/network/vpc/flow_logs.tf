resource "aws_flow_log" "s3_accept" {
  iam_role_arn             = module.iam_for_s3.iam_role_arn
  log_destination          = aws_s3_bucket.flow_accept.arn
  log_destination_type     = "s3"
  vpc_id                   = module.vpc.vpc_id
  traffic_type             = "ACCEPT"
  max_aggregation_interval = 60
  log_format               = var.vpc_flow_log_format
  tags                     = merge(local.tags, { Name = format("private-s3-flow-log-accept") })
}

resource "aws_flow_log" "s3_reject" {
  iam_role_arn             = module.iam_for_s3.iam_role_arn
  log_destination          = aws_s3_bucket.flow_reject.arn
  log_destination_type     = "s3"
  vpc_id                   = module.vpc.vpc_id
  traffic_type             = "REJECT"
  max_aggregation_interval = 60
  log_format               = var.vpc_flow_log_format
  tags                     = merge(local.tags, { Name = format("private-s3-flow-log-reject") })
}

resource "aws_flow_log" "cwlogs_private_accept" {
  iam_role_arn             = module.iam_for_cw.iam_role_arn
  log_destination          = aws_cloudwatch_log_group.accept.arn
  log_destination_type     = "cloud-watch-logs"
  vpc_id                   = module.vpc.vpc_id
  traffic_type             = "ACCEPT"
  max_aggregation_interval = 60
  log_format               = var.vpc_flow_log_format
  tags                     = merge(local.tags, { Name = format("cwlogs-flow-log-accept") })
}

resource "aws_flow_log" "cwlogs_private_reject" {
  iam_role_arn             = module.iam_for_cw.iam_role_arn
  log_destination          = aws_cloudwatch_log_group.reject.arn
  log_destination_type     = "cloud-watch-logs"
  vpc_id                   = module.vpc.vpc_id
  traffic_type             = "REJECT"
  max_aggregation_interval = 60
  log_format               = var.vpc_flow_log_format
  tags                     = merge(local.tags, { Name = format("cwlogs-flow-log-reject") })
}
