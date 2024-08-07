variable "BINANCE_FUTURES_KLINE_EXCHANGE-CONNECTOR_REST-CLICKHOUSE" {
  type        = string
  description = "value of the version of the connector"

  nullable = false
}

variable "BYBIT_FUTURES_KLINE_EXCHANGE-CONNECTOR_REST-CLICKHOUSE" {
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
