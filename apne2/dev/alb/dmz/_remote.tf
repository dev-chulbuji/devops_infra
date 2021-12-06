data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.backend_s3
    key    = var.vpc_key
    region = var.region
  }
}

data "terraform_remote_state" "target" {
  backend = "s3"
  config = {
    bucket = var.backend_s3
    key    = var.target_key
    region = var.region
  }
}