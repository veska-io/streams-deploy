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
  nat_ips                            = [var.static_ips[0]]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnets[0]
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "cloud_nat_1" {
  name                               = format("%s%s", var.prefix, "cloud-nat-1")
  router                             = google_compute_router.cloud_router_0.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [var.static_ips[1]]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.subnets[1]
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


output "cloud_nat_0" {
  value = google_compute_router_nat.cloud_nat_0
}

output "cloud_nat_1" {
  value = google_compute_router_nat.cloud_nat_1
}
