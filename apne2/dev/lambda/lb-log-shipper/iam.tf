data "aws_iam_policy_document" "sts_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.sts_lambda.json
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.name}-policy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.this.json
}