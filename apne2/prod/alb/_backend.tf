terraform {
  backend "s3" {
    bucket      = "devops-prod-tfbackend-s3"
    key         = "apne2/alb/app/terraform.tfstate"
    region      = "ap-northeast-2"
#    role_arn    = "{ASSUMED_ROLE}"
    max_retries = 3
  }
}
