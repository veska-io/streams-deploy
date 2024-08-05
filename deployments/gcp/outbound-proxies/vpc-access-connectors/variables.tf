variable "prefix" {
  type        = string
  description = "value to be used as prefix for resources"

  default = ""
}

variable "region" {
  type        = string
  description = "Region"

  nullable = false
}

variable "network_id" {
  type        = string
  description = "Network"

  nullable = false
}

variable "subnets" {
  type        = list(string)
  description = "Subnets Names"

  nullable = false
}
