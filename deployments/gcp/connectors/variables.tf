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

variable "INTERNAL_EXCHANGES-EVENTS" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "INTERNAL_AGGREGATES" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BINANCE_FUTURES_KLINE_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BINANCE_FUTURES_FUNDING-RATE_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BINANCE_FUTURES_OPEN-INTEREST_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BYBIT_FUTURES_KLINE_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BYBIT_FUTURES_FUNDING-RATE_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BYBIT_FUTURES_OPEN-INTEREST_EVENTS-GENERATOR" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "CLICKHOUSE_EXCHANGES_EVENTS_TABLE" {
  type = string

  nullable = false
}

variable "CLICKHOUSE_AGGREGATES_TABLE" {
  type = string

  nullable = false
}


variable "CLICKHOUSE_HOST" {
  type = string

  nullable = false
}

variable "CLICKHOUSE_PORT" {
  type = number

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
