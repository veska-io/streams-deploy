provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.PROVIDER_REGION
}

module "schedule_hourly_1m" {
  source = "./schedules/hourly-1m"

  prefix = var.PREFIX
}

module "binance_futures_kline_restc" {
  source = "./binance/futures/kline/exchange-connector/rest-clickhouse"

  prefix             = var.PREFIX
  bucket_name        = "${var.PREFIX}functions-deploy"
  artifact_name      = "binance_futures_kline_exchange-connector_rest-clickhouse@${var.BINANCE_FUTURES_KLINE_EXCHANGE-CONNECTOR_REST-CLICKHOUSE_VER}.zip"
  vpc_connector_name = "${var.PREFIX}vpc-connector-0"
  schedule_topic_id  = module.schedule_hourly_1m.scheduled_topic.id

  clickhouse_host     = var.CLICKHOUSE_HOST
  clickhouse_user     = var.CLICKHOUSE_USER
  clickhouse_password = var.CLICKHOUSE_PASSWORD
  clickhouse_database = var.CLICKHOUSE_DATABASE

  depends_on = [module.schedule_hourly_1m.scheduled_job, module.schedule_hourly_1m.scheduled_topic]
}
