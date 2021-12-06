locals {
  region = var.region
  name   = format("%s-lambda", var.name)

  envs = {
    CW_LOG_GROUP  = var.env_cw_loggroup
    INPUT_FORMAT  = var.env_input_format
    OUTPUT_FORMAT = var.env_output_format
  }

  tags = merge(var.tags, { Owner = var.owner, Environment = var.env })
}
