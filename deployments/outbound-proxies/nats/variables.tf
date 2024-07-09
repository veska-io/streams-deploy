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

variable "static_ip_id" {
  type        = string
  description = "ID of the Static IP"

  nullable = false
}

variable "subnet_name" {
  type        = string
  description = "Name of the Subnet"

  nullable = false
}

variable "net_name" {
  type        = string
  description = "Network Name"

  nullable = false
}
