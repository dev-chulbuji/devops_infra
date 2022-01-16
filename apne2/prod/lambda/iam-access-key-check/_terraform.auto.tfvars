env   = "dev"
name  = "iam-access-key-check"
owner = "dj.kim"
tags  = {}

runtime = "nodejs14.x"
handler = "app.handler"
timeout = 60

cw_schedule_expression = "cron(0 2 * * ? *)" # 11시

#KEY_MAX_AGE_SECS = "360"
IS_DELETE_EXPIRED_KEY = "true"

#KEY_MAX_INACTIVE_AGE = "1200"
IS_INACTIVE_USEUSED_KEY = "false"