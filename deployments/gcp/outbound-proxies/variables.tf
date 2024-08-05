variable "PREFIX" {
  type        = string
  description = "Prefix for resuorces"

  default = ""
}

variable "GCP_PROJECT_ID" {
  type        = string
  description = "GCP Project ID"

  nullable = false
}

variable "PROVIDER_REGION" {
  type        = string
  description = "Region for the Provider"

  nullable = false
}
