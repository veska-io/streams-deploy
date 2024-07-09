resource "google_compute_router" "cloud_router_0" {
  name    = format("%s%s", var.prefix, "cloud-router-0")
  network = var.net_name
  region  = var.region
}

resource "google_compute_router_nat" "cloud_nat_0" {
  name                               = format("%s%s", var.prefix, "cloud-nat-0")
  router                             = google_compute_router.cloud_router_0.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [var.static_ip_id]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnet_name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

output "cloud_nat" {
  value = google_compute_router_nat.cloud_nat_0
}



















/*
resource "google_compute_router_nat" "cloud_nat_1" {
  name                               = "cloud-nat-1"
  router                             = google_compute_router.cloud_router_1.name
  region                             = "eu-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_ip_1.id]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "cloud_nat_2" {
  name                               = "cloud-nat-2"
  router                             = google_compute_router.cloud_router_2.name
  region                             = "eu-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_ip_2.id]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "cloud_nat_3" {
  name                               = "cloud-nat-3"
  router                             = google_compute_router.cloud_router_3.name
  region                             = "eu-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_ip_3.id]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "cloud_nat_4" {
  name                               = "cloud-nat-4"
  router                             = google_compute_router.cloud_router_4.name
  region                             = "eu-west1"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.static_ip_4.id]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
*/
