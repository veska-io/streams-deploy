variable "name" {
  type = string

  nullable = false
}

variable "artifact_name" {
  type = string

  nullable = false
}

variable "events_topic_id" {
  type = string

  nullable = false
}

variable "trigger_topic_id" {
  type = string

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

variable "clickhouse_user" {
  type = string

  nullable = false
}

variable "clickhouse_password" {
  type = string

  nullable = false
}
