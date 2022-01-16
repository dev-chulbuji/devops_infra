locals {
  region                 = var.region
  name                   = format("%s-lambda", var.name)
  cw_event_rule          = format("%s-rule", var.name)
  cw_schedule_expression = var.cw_schedule_expression
  envs = {
    IS_DELETE_EXPIRED_KEY   = var.IS_DELETE_EXPIRED_KEY
    IS_INACTIVE_USEUSED_KEY = var.IS_INACTIVE_USEUSED_KEY
#    KEY_MAX_AGE_SECS        = var.KEY_MAX_AGE_SECS
#    KEY_MAX_INACTIVE_AGE    = var.KEY_MAX_INACTIVE_AGE
  }

  tags = merge(var.tags, { Owner = var.owner, Environment = var.env })
}
