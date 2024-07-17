resource "google_compute_address" "static_ip_0" {
  name   = format("%s%s", var.prefix, "static-ip-0")
  region = var.region
}

resource "google_compute_address" "static_ip_1" {
  name   = format("%s%s", var.prefix, "static-ip-1")
  region = var.region
}

output "static_ip_0" {
  value = google_compute_address.static_ip_0
}

output "static_ip_1" {
  value = google_compute_address.static_ip_1
}
