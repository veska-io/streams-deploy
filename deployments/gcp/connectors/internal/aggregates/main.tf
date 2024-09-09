module "exchanges_events_schedule" {
  source = "./schedule"
}

module "internal_exchanges_events_pubsub_clickhouse" {
  source = "./connector"

  name          = "internal-aggregates"
  artifact_name = "internal_aggregates@${var.aggregates_version}.zip"

  trigger_topic_id = module.exchanges_events_schedule.schedule_topic.id

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_table    = var.clickhouse_table
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password
}
