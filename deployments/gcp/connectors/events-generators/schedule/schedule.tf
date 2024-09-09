# Schedule
resource "google_pubsub_topic" "schedule_topic" {
  name = "events-generators-schedule-topic"
}

resource "google_cloud_scheduler_job" "schedule_job" {
  name        = "events-generators-schedule-job"
  description = "Job to trigger the Cloud Function on a schedule"
  schedule    = "5 * * * *"
  time_zone   = "UTC"

  pubsub_target {
    topic_name = google_pubsub_topic.schedule_topic.id
    data       = base64encode(jsonencode({ "message" : "1" }))
  }
}

output "schedule_topic" {
  value = google_pubsub_topic.schedule_topic
}
