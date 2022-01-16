resource "aws_cloudwatch_event_rule" "this" {
  name                = local.cw_event_rule
  description         = local.cw_event_rule
  schedule_expression = local.cw_schedule_expression
}

resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
  target_id = local.cw_event_rule
  rule      = aws_cloudwatch_event_rule.this.name
  arn       = module.lambda.arn
}