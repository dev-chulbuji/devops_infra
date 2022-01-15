env   = "prod"
owner = "dj.kim"
name  = "eks-log"
tags  = {}

# remote
es_key = "apne2/opensearch/terraform.tfstate"

kinesis_delivery_stream_destination = "elasticsearch"
kinesis_s3_backup_mode              = "Disabled"

# ES
index_name = "eks-log"

# IAM
trusted_role_services = ["firehose.amazonaws.com"]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonOpenSearchServiceFullAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AmazonKinesisFullAccess",
  "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"
]
additional_policy_actions = []