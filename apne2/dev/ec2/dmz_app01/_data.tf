data "aws_caller_identity" "current" {}

data "aws_ami" "this" {
  most_recent = true
  owners      = local.ami_owners

  dynamic "filter" {
    for_each = local.ami_filters
    content {
      name = lookup(filter.value, "name")
      values = lookup(filter.value, "values")
    }
  }
}

data "template_file" "userdata" {
  template = file("templates/userdata.sh")
  vars = {
    ACCOUNT_ID = data.aws_caller_identity.current.account_id
    REGION = var.region

    DOCKER_IMAGE_NAME = var.docker_image_name
    DOCKER_IMAGE_TAG = var.docker_image_tag
  }
}