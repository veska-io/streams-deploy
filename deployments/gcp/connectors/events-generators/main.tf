module "schedule" {
  source = "./schedule"
}

module "binance_futures_kline_events_generator" {
  source = "./connector"

  name          = "binance-futures-kline-events-generator"
  artifact_name = "binance_futures_kline_events-generator@${var.binance_futures_kline_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}

module "binance_futures_funding_rate_events_generator" {
  source = "./connector"

  name          = "binance-futures-funding-rate-events-generator"
  artifact_name = "binance_futures_funding-rate_events-generator@${var.binance_futures_funding_rate_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}

module "binance_futures_open_interest_events_generator" {
  source = "./connector"

  name          = "binance-futures-open-interest-events-generator"
  artifact_name = "binance_futures_open-interest_events-generator@${var.binance_futures_open_interest_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}

module "bybit_futures_kline_events_generator" {
  source = "./connector"

  name          = "bybit-futures-kline-events-generator"
  artifact_name = "bybit_futures_kline_events-generator@${var.bybit_futures_kline_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}

module "bybit_futures_funding_rate_events_generator" {
  source = "./connector"

  name          = "bybit-futures-funding-rate-events-generator"
  artifact_name = "bybit_futures_funding-rate_events-generator@${var.bybit_futures_funding_rate_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}

module "bybit_futures_open_interest_events_generator" {
  source = "./connector"

  name          = "bybit-futures-open-interest-events-generator"
  artifact_name = "bybit_futures_open-interest_events-generator@${var.bybit_futures_open_interest_events_generator_version}.zip"

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password

  trigger_topic_id = module.schedule.schedule_topic.id
  events_topic_id  = var.events_topic_id
}
