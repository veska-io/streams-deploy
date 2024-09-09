provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.PROVIDER_REGION
}

terraform {
  backend "gcs" {
    bucket = "streams-functions-deploy"
    prefix = "terraform/connectors-state"
  }
}


module "exchange-events-connector" {
  source = "./internal/exchanges-events"

  internal_exchanges_events_version = var.INTERNAL_EXCHANGES-EVENTS

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_port     = var.CLICKHOUSE_PORT
  clickhouse_database = var.CLICKHOUSE_DATABASE
  clickhouse_table    = var.CLICKHOUSE_EXCHANGES_EVENTS_TABLE
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
}

module "aggregates-connector" {
  source = "./internal/aggregates"

  aggregates_version = var.INTERNAL_AGGREGATES

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_port     = var.CLICKHOUSE_PORT
  clickhouse_database = var.CLICKHOUSE_DATABASE
  clickhouse_table    = var.CLICKHOUSE_AGGREGATES_TABLE
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
}

module "events-generators" {
  source = "./events-generators"

  binance_futures_kline_events_generator_version         = var.BINANCE_FUTURES_KLINE_EVENTS-GENERATOR
  binance_futures_funding_rate_events_generator_version  = var.BINANCE_FUTURES_FUNDING-RATE_EVENTS-GENERATOR
  binance_futures_open_interest_events_generator_version = var.BINANCE_FUTURES_OPEN-INTEREST_EVENTS-GENERATOR
  bybit_futures_kline_events_generator_version           = var.BYBIT_FUTURES_KLINE_EVENTS-GENERATOR
  bybit_futures_funding_rate_events_generator_version    = var.BYBIT_FUTURES_FUNDING-RATE_EVENTS-GENERATOR
  bybit_futures_open_interest_events_generator_version   = var.BYBIT_FUTURES_OPEN-INTEREST_EVENTS-GENERATOR

  events_topic_id = module.exchange-events-connector.exchanges_events_stream.name

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_port     = var.CLICKHOUSE_PORT
  clickhouse_database = var.CLICKHOUSE_DATABASE
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
}
