variable "env" {}
variable "name" {}
variable "owner" {}

variable "cluster_version" {}
variable "cluster_endpoint_private_access" {}
variable "cluster_endpoint_public_access" {}

variable "worker_instance_type" {}
variable "worker_instance_count" {}
variable "worker_instance_public_ip" {}

variable "trusted_role_services" {}
variable "custom_role_policy_arns" {}
variable "additional_policy_actions" {}