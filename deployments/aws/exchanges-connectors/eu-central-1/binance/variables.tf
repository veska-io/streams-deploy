
variable "build_version" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "role_arn" {
  type        = string
  description = "Role ARN"

  nullable = false
}

variable "schedule_arn" {
  type        = string
  description = "Schedule ARN"

  nullable = false
}

variable "schedule_name" {
  type        = string
  description = "Schedule name"

  nullable = false
}

variable "clickhouse_host" {
  type = string

  nullable = false
}

variable "clickhouse_database" {
  type = string

  nullable = false
}

variable "clickhouse_user" {
  type = string

  nullable = false
}

variable "clickhouse_password" {
  type = string

  nullable = false
}
