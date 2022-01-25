env   = "prod"
name  = "dmz-app"
owner = "dj.kim"
tags  = {}

target_key = "apne2/ec2/dmz_app/terraform.tfstate"

# sg
http_sg_description      = "HTTP Security group for Bastion EC2 instance"
http_ingress_cidr_blocks = ["0.0.0.0/0"]
http_ingress_rules       = ["http-80-tcp"]
http_egress_rules        = ["all-all"]

# alb
http_tcp_listeners = [
  {
    port        = 80
    protocol    = "HTTP"
    action_type = "fixed-response"
    fixed_response = {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "403"
    }
  }
]
http_tcp_listener_rules = [
  {
    http_listener_index = 0
    actions = [{
      type               = "forward"
      target_group_index = 0
    }]
    conditions = [{
      path_patterns = ["/*"]
    }]
  }
]

target_type      = "instance"
backend_protocol = "HTTP"
backend_port     = 80
health_check_url = "/"