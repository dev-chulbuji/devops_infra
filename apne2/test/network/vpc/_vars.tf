variable "env" {}
variable "name" {}
variable "owner" {}
variable "region" {}

variable "vpc_cidr" {}
variable "azs" {}
variable "public_subnets" {}
variable "enable_ipv6" {
  default = false
}
variable "enable_nat_gateway" {
  default = false
}
variable "public_subnet_tags" {}
variable "vpc_tags" {}
variable "tags" {}