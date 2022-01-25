terraform {
  backend "s3" {
    bucket      = "devops-prod-tfbackend-s3"
    key         = "apne2/ec2/private_app/terraform.tfstate"
    region      = "ap-northeast-2"
    role_arn    = "arn:aws:iam::552661052297:role/terraform-runner-role"
    max_retries = 3
  }
}
