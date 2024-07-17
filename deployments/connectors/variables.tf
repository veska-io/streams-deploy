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

variable "BINANCE_FUTURES_KLINE_EXCHANGE-CONNECTOR_REST-CLICKHOUSE" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BINANCE_FUTURES_FUNDING-RATE_EXCHANGE-CONNECTOR_REST-CLICKHOUSE" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "CLICKHOUSE_HOST" {
  type = string

  nullable = false
}

variable "CLICKHOUSE_DATABASE" {
  type = string

  nullable = false
}

variable "CLICKHOUSE_USER" {
  type = string

  nullable = false
}

variable "CLICKHOUSE_PASSWORD" {
  type = string

  nullable = false
}
