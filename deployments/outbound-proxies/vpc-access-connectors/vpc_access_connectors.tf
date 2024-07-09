resource "google_vpc_access_connector" "vpc_connector_0" {
  name = format("%s%s", var.prefix, "vpc-connector-0")

  region = var.region

  subnet {
    name = var.subnet_name
  }
}

output "vpc_connector" {
  value = google_vpc_access_connector.vpc_connector_0
}























/*
resource "google_vpc_access_connector" "vpc_connector_1" {
  name = "vpc-connector-1"

  subnet {
    name = var.subnets[1]
  }
}

resource "google_vpc_access_connector" "vpc_connector_2" {
  name = "vpc-connector-2"

  subnet {
    name = var.subnets[2]
  }
}

resource "google_vpc_access_connector" "vpc_connector_3" {
  name = "vpc-connector-3"

  subnet {
    name = var.subnets[3]
  }
}

resource "google_vpc_access_connector" "vpc_connector_4" {
  name = "vpc-connector-4"

  subnet {
    name = var.subnets[4]
  }
}
*/
