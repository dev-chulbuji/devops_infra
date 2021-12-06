resource "aws_lambda_permission" "this" {
  for_each = var.allowed_triggers

  function_name = lookup(each.value, "function_name", null)
  qualifier     = lookup(each.value, "qualifier", null)

  statement_id       = lookup(each.value, "statement_id", each.key)
  action             = lookup(each.value, "action", "lambda:InvokeFunction")
  principal          = lookup(each.value, "principal", format("%s.amazonaws.com", lookup(each.value, "service", "")))
  source_arn         = lookup(each.value, "source_arn", lookup(each.value, "service", null) == "apigateway" ? "${lookup(each.value, "arn", "")}/*/*/*" : null)
  source_account     = lookup(each.value, "source_account", null)
  event_source_token = lookup(each.value, "event_source_token", null)
}
