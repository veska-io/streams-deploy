# Cloud Function
resource "google_cloudfunctions2_function" "exchanges_events_connector" {
  name = var.name

  location = "europe-west1"

  build_config {
    runtime     = "go122"
    entry_point = "RunMain"

    source {
      storage_source {
        bucket = "streams-functions-deploy"
        object = var.artifact_name
      }
    }
  }

  service_config {
    timeout_seconds    = 120
    available_memory   = "256Mi"
    max_instance_count = 1

    environment_variables = {
      // terraform/gcp always sets this, causing redeploy
      LOG_EXECUTION_ID = "true"

      CONNECTOR_DEBUG                = "false"
      CONNECTOR_CLOUD_FUNCTION       = "true"
      CONNECTOR_IDLE-TIMEOUT-SECONDS = 5

      CONNECTOR_PRODUCER_HOST     = var.clickhouse_host
      CONNECTOR_PRODUCER_PORT     = var.clickhouse_port
      CONNECTOR_PRODUCER_DATABASE = var.clickhouse_database
      CONNECTOR_PRODUCER_USER     = var.clickhouse_user
      CONNECTOR_PRODUCER_PASSWORD = var.clickhouse_password
      CONNECTOR_PRODUCER_TABLE    = var.clickhouse_table

      CONNECTOR_CONSUMER_TOPIC-ID        = var.events_topic_id
      CONNECTOR_CONSUMER_SUBSCRIPTION-ID = var.subscription_id
      CONNECTOR_CONSUMER_PROJECT-ID      = "veska-io"
    }
  }

  event_trigger {
    event_type   = "google.cloud.pubsub.topic.v1.messagePublished"
    retry_policy = "RETRY_POLICY_DO_NOT_RETRY"

    pubsub_topic = var.trigger_topic_id
  }
}
