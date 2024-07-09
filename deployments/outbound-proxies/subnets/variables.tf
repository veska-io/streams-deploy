variable "prefix" {
  type        = string
  description = "Prefix"

  default = ""
}

variable "region" {
  type        = string
  description = "Region for the Subnets"

  nullable = false
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"

  nullable = false
}
