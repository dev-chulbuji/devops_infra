env   = "dev"
name  = "lb-log-shipper"
owner = "dj.kim"
tags  = {}

runtime = "python3.7"
handler = "lambda_function.lambda_handler"
timeout = 60

env_cw_loggroup   = "/aws/alb/access_log"
env_input_format  = "alb"
env_output_format = "json"