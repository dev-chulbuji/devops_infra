env   = "prod"
owner = "dj.kim"
tags  = {}

serviceAccounts = [
  {
    name: "aws-cli"
    namespace: "default",
    policy_arns: [
      "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    ]
  },
  {
    name: "irsa-test"
    namespace: "default",
    policy_arns: [
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]
  }
]