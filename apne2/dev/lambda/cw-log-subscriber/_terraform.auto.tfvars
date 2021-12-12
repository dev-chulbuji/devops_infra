env   = "dev"
name  = "cw-log-subscriber"
owner = "dj.kim"
tags  = {}

runtime = "nodejs14.x"
handler = "app.handler"
timeout = 60

log_group_name = "/aws/ec2/var/log/messages"