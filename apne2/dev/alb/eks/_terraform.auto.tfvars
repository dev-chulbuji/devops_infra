env   = "dev"
name  = "eks"
owner = "dj.kim"
tags  = {}

eks_key = "dev/apne2/eks/demo/terraform.tfstate"

http_ingress_cidr_blocks = ["0.0.0.0/0"]
http_ingress_rules       = ["http-80-tcp"]
http_egress_rules        = ["all-all"]

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