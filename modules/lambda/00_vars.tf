variable "name" {}
variable "source_path" {}
variable "role_arn" {}
variable "tags" {}

variable "log_retention_in_days" {
  description = "CloudWatch Logs retention period in days"
  default     = 365
}

variable "memory_size" {
  description = "Memory size for Lambda runtime"
  default     = "128"
}

variable "handler" {
  description = "Lambda function entrypoint"
}

variable "runtime" {
  description = "Lambda function runtime"
}

variable "timeout" {
  description = "lambda timeout"
  default     = 60
}

variable "environments" {
  description = "lambda environment variables map"
  default     = {}
}
