variable "env" {}
variable "name" {}
variable "owner" {}

variable "runtime" {}
variable "handler" {}
variable "timeout" {}

variable "cw_schedule_expression" {}

variable "IS_DELETE_EXPIRED_KEY" {}
variable "IS_INACTIVE_USEUSED_KEY" {}
variable "KEY_MAX_AGE_SECS" { default = null }
variable "KEY_MAX_INACTIVE_AGE" { default = null }