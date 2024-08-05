variable "prefix" {
  type        = string
  description = "Prefix for names"

  nullable = false
}

variable "region" {
  type        = string
  description = "Region for the NATs"

  nullable = false
}

variable "static_ips" {
  type        = list(string)
  description = "IDs of the Static IP"

  nullable = false
}

variable "subnets" {
  type        = list(string)
  description = "Subnets Names"

  nullable = false
}

variable "net_name" {
  type        = string
  description = "Network Name"

  nullable = false
}
