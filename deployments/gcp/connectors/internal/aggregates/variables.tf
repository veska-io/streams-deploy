
variable "aggregates_version" {
  type        = string
  description = "Connector version"

  nullable = false
}

variable "clickhouse_host" {
  type = string

  nullable = false
}

variable "clickhouse_port" {
  type = number

  nullable = false
}

variable "clickhouse_database" {
  type = string

  nullable = false
}

variable "clickhouse_table" {
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
