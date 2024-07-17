resource "google_vpc_access_connector" "vpc_connector_0" {
  name = format("%s%s", var.prefix, "vpc-connector-0")

  region = var.region

  subnet {
    name = var.subnets[0]
  }
}

resource "google_vpc_access_connector" "vpc_connector_1" {
  name = format("%s%s", var.prefix, "vpc-connector-1")

  region = var.region

  subnet {
    name = var.subnets[1]
  }
}

output "vpc_connector_0" {
  value = google_vpc_access_connector.vpc_connector_0
}

output "vpc_connector_1" {
  value = google_vpc_access_connector.vpc_connector_1
}
