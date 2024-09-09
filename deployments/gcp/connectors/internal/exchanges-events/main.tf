# Main topic for the connector
resource "google_pubsub_topic" "exchanges_events_stream" {
  name = "exchanges-events-stream"
  schema_settings {
    schema   = "projects/veska-io/schemas/futures-exchanges-events"
    encoding = "BINARY"
  }
}

resource "google_pubsub_subscription" "exchanges_events_stream_sub" {
  name  = "exchanges_events_clickhouse_connector"
  topic = google_pubsub_topic.exchanges_events_stream.name
}

module "exchanges_events_schedule" {
  source = "./schedule"
}

module "internal_exchanges_events_pubsub_clickhouse" {
  source = "./connector"

  name          = "internal-exchanges-events"
  artifact_name = "internal_exchanges-events@${var.internal_exchanges_events_version}.zip"

  events_topic_id  = google_pubsub_topic.exchanges_events_stream.id
  trigger_topic_id = module.exchanges_events_schedule.schedule_topic.id
  subscription_id  = google_pubsub_subscription.exchanges_events_stream_sub.name

  clickhouse_host     = var.clickhouse_host
  clickhouse_port     = var.clickhouse_port
  clickhouse_database = var.clickhouse_database
  clickhouse_table    = var.clickhouse_table
  clickhouse_user     = var.clickhouse_user
  clickhouse_password = var.clickhouse_password
}

output "exchanges_events_stream" {
  value = google_pubsub_topic.exchanges_events_stream
}
