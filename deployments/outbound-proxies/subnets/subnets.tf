resource "google_compute_subnetwork" "subnet_0" {
  name          = format("%s%s", var.prefix, "subnet-0")
  ip_cidr_range = "10.8.0.0/28"
  network       = var.vpc_id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = format("%s%s", var.prefix, "subnet-1")
  ip_cidr_range = "10.8.1.0/28"
  network       = var.vpc_id
  region        = var.region
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = format("%s%s", var.prefix, "subnet-2")
  ip_cidr_range = "10.8.2.0/28"
  network       = var.vpc_id
  region        = var.region
}

output "subnet_0" {
  value = google_compute_subnetwork.subnet_0
}

output "subnet_1" {
  value = google_compute_subnetwork.subnet_1
}
