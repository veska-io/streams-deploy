variable "prefix" {
  type        = string
  description = "Prefix"

  default = ""
}
variable "bucket_name" {
  type        = string
  description = "Bucket name"

  nullable = false
}

variable "artifact_name" {
  type        = string
  description = "Artifact name"

  nullable = false
}

variable "vpc_connector_name" {
  type        = string
  description = "VPC name"

  nullable = false
}

variable "schedule_topic_id" {
  type        = string
  description = "Schedule topic name"

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
