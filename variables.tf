variable "temporal_cloud_api_key" {
  description = "Temporal Cloud API Key"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.temporal_cloud_api_key) > 0
    error_message = "Temporal Cloud API Key is required."
  }
}

variable "temporal_cloud_allowed_account_id" {
  description = "Temporal Cloud Allowed Account ID"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.temporal_cloud_allowed_account_id) > 0
    error_message = "Temporal Cloud Allowed Account ID is required."
  }
}

variable "config_file" {
  default = "config/config.yml"
  type    = string
}