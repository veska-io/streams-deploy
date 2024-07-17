provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.PROVIDER_REGION
}

terraform {
  backend "gcs" {
    bucket = "streams-functions-deploy"
    prefix = "terraform/storage-bucket-state"
  }
}

// ==============================================================================================

resource "google_storage_bucket" "bucket" {
  name                        = format("%s%s", var.PREFIX, "functions-deploy")
  location                    = var.PROVIDER_REGION
  force_destroy               = true # Set to false if you want to prevent the bucket from being deleted if it contains objects
  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 40
    }
  }
}

output "bucket" {
  value = google_storage_bucket.bucket
}
