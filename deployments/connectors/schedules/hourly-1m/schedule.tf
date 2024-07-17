resource "google_pubsub_topic" "scheduled_topic" {
  name = "${var.prefix}schedule-topic-hourly-1m"
}

resource "google_cloud_scheduler_job" "scheduled_job" {
  name        = "${var.prefix}scheduler-hourly-1m"
  description = "Job to trigger the Cloud Function on a schedule"
  schedule    = "1 * * * *"
  time_zone   = "UTC"

  pubsub_target {
    topic_name = google_pubsub_topic.scheduled_topic.id
    data       = base64encode(jsonencode({ "message" : "1" }))
  }
}

resource "google_pubsub_topic" "scheduled_topic_5m" {
  name = "${var.prefix}schedule-topic-hourly-5m"
}

resource "google_cloud_scheduler_job" "scheduled_job_5m" {
  name        = "${var.prefix}scheduler-hourly-5m"
  description = "Job to trigger the Cloud Function on a schedule"
  schedule    = "5 * * * *"
  time_zone   = "UTC"

  pubsub_target {
    topic_name = google_pubsub_topic.scheduled_topic_5m.id
    data       = base64encode(jsonencode({ "message" : "1" }))
  }
}

output "scheduled_job" {
  value = google_cloud_scheduler_job.scheduled_job
}

output "scheduled_topic" {
  value = google_pubsub_topic.scheduled_topic
}

output "scheduled_topic_5m" {
  value = google_pubsub_topic.scheduled_topic_5m
}
