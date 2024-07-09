resource "google_compute_address" "static_ip_0" {
  name   = format("%s%s", var.prefix, "static-ip-0")
  region = var.region
}

output "static_ip" {
  value = google_compute_address.static_ip_0
}

/*
resource "google_compute_address" "static_ip_1" {
  name   = "nat-static-ip-1"
  region = "eu-west1"
}

resource "google_compute_address" "static_ip_2" {
  name   = "nat-static-ip-2"
  region = "eu-west1"
}

resource "google_compute_address" "static_ip_3" {
  name   = "nat-static-ip-3"
  region = "eu-west1"
}

resource "google_compute_address" "static_ip_4" {
  name   = "nat-static-ip-4"
  region = "eu-west1"
}
*/
