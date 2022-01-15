resource "aws_s3_bucket" "this" {
  bucket = local.s3_name
  acl    = "private"
}