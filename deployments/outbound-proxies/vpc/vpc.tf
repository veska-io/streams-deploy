resource "google_compute_network" "vpc" {
  name                    = format("%s%s", var.prefix, "vpc")
  auto_create_subnetworks = false
}

output "vpc" {
  value = google_compute_network.vpc
}
