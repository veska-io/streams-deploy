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

variable "events_topic_id" {
  type = string

  nullable = false
}

variable "binance_futures_kline_events_generator_version" {
  type = string

  nullable = false
}

variable "binance_futures_open_interest_events_generator_version" {
  type = string

  nullable = false
}

variable "binance_futures_funding_rate_events_generator_version" {
  type = string

  nullable = false
}

variable "bybit_futures_kline_events_generator_version" {
  type = string

  nullable = false
}

variable "bybit_futures_open_interest_events_generator_version" {
  type = string

  nullable = false
}

variable "bybit_futures_funding_rate_events_generator_version" {
  type = string

  nullable = false
}
