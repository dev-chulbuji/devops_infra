variable "env" {}
variable "name" {}
variable "owner" {}
variable "region" {}

variable "vpc_cidr" {}
variable "azs" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "gwlb_subnets" {}
variable "enable_ipv6" {
  default = false
}
variable "enable_nat_gateway" {
  default = false
}
variable "single_nat_gateway" {
  default = true
}
variable "private_subnet_tags" {}
variable "public_subnet_tags" {}
variable "vpc_tags" {}
variable "tags" {}

variable "vpc_flow_retention_days" {}
variable "vpc_flow_log_format" {
  description = "Private VPC flow log format"
  default     = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status}"
#  default     = "$${version} $${vpc-id} $${subnet-id} $${instance-id} $${interface-id} $${account-id} $${type} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${pkt-srcaddr} $${pkt-dstaddr} $${protocol} $${bytes} $${packets} $${start} $${end} $${action} $${tcp-flags} $${log-status}"
}