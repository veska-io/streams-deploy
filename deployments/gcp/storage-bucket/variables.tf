variable "GCP_PROJECT_ID" {
  type        = string
  description = "Google Project ID"

  nullable = false
}

variable "PREFIX" {
  type        = string
  description = "Prefix"

  default = ""
}

variable "PROVIDER_REGION" {
  type        = string
  description = "Region"

  nullable = false
}
