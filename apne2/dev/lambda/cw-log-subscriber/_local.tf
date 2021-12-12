locals {
  region = var.region
  name   = format("%s-lambda", var.name)

  envs = {}

  tags = merge(var.tags, { Owner = var.owner, Environment = var.env })
}
