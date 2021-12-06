variable "allowed_triggers" {
  description = "Map of allowed triggers to create Lambda permissions"
  type        = map(any)
  default     = {}
}
