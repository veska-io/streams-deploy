data "google_storage_bucket_object" "binance_futures_open_interest" {
  bucket = var.bucket_name
  name   = var.artifact_name
}

resource "google_cloudfunctions2_function" "binance_futures_open_interest_restc" {
  name        = format("%s%s", var.prefix, "binance-futures-open-interest-clickhouse")
  description = "Binance Futures Open Interest Connector"
  location    = "europe-west1"

  build_config {
    runtime     = "go122"
    entry_point = "RunMain"

    source {
      storage_source {
        bucket = data.google_storage_bucket_object.binance_futures_open_interest.bucket
        object = data.google_storage_bucket_object.binance_futures_open_interest.name
      }
    }
  }

  service_config {
    timeout_seconds    = 120
    available_memory   = "256Mi"
    max_instance_count = 1

    environment_variables = {
      // terraform always sets this, causing redeploy
      LOG_EXECUTION_ID = "true"

      CONNECTOR_DEBUG             = "false"
      CONNECTOR_PRODUCER_HOST     = var.clickhouse_host
      CONNECTOR_PRODUCER_DATABASE = var.clickhouse_database
      CONNECTOR_PRODUCER_USER     = var.clickhouse_user
      CONNECTOR_PRODUCER_PASSWORD = var.clickhouse_password
      CONNECTOR_PRODUCER_TABLE    = "binance_futures_open_interest_1h"
    }

    vpc_connector                 = var.vpc_connector_name
    vpc_connector_egress_settings = "ALL_TRAFFIC"

  }

  event_trigger {
    event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic = var.schedule_topic_id
    retry_policy = "RETRY_POLICY_DO_NOT_RETRY"
  }
}
