resource "aws_elasticsearch_domain" "this" {
  domain_name           = local.name
  elasticsearch_version = local.es_version

  cluster_config {
    instance_type  = local.instance_type
    instance_count = local.instance_count
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${local.name}/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": ["${var.access_cidr}"]}
      }
    }
  ]
}
POLICY

  tags = local.tags
}