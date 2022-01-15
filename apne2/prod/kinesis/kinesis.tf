#resource "aws_kinesis_stream" "this" {
#  name             = local.kinesis_stream_name
#  retention_period = 24
#
#  stream_mode_details {
#    stream_mode = "ON_DEMAND"
#  }
#
#  tags = merge(local.tags, { Name = local.kinesis_stream_name })
#}

resource "aws_kinesis_firehose_delivery_stream" "this" {
  name        = local.kinesis_delivery_stream_name
  destination = var.kinesis_delivery_stream_destination

#  kinesis_source_configuration {
#    kinesis_stream_arn = aws_kinesis_stream.this.arn
#    role_arn           = module.iam.iam_role_arn
#  }

  s3_configuration {
    role_arn           = module.iam.iam_role_arn
    bucket_arn         = aws_s3_bucket.this.arn
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
  }

  elasticsearch_configuration {
    domain_arn = local.es_arn
    role_arn   = module.iam.iam_role_arn

    index_name = var.index_name
    index_rotation_period = "OneDay"

    processing_configuration {
      enabled = "false"
    }
  }

  tags = merge(local.tags, { Name = local.kinesis_delivery_stream_name })
}