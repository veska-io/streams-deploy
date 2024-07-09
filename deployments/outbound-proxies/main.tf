provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.PROVIDER_REGION
}

module "vpc" {
  source = "./vpc"
  prefix = var.PREFIX
}

module "subnets" {
  source = "./subnets"
  prefix = var.PREFIX
  region = var.PROVIDER_REGION
  vpc_id = module.vpc.vpc.id

  depends_on = [module.vpc]
}

module "static_ips" {
  source = "./static-ips"
  prefix = var.PREFIX
  region = var.PROVIDER_REGION
}

module "vpc_access_connectors" {
  source = "./vpc-access-connectors"

  prefix      = var.PREFIX
  region      = var.PROVIDER_REGION
  network_id  = format("%s%s", var.PREFIX, "vpc")
  subnet_name = module.subnets.subnet.name
}

module "nat" {
  source = "./nats"
  prefix = var.PREFIX
  region = var.PROVIDER_REGION

  static_ip_id = module.static_ips.static_ip.id
  net_name     = module.vpc.vpc.name
  subnet_name  = module.subnets.subnet.name

  depends_on = [module.vpc, module.subnets, module.static_ips]
}
