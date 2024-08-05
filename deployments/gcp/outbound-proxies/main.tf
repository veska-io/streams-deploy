provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.PROVIDER_REGION
}

terraform {
  backend "gcs" {
    bucket = "streams-functions-deploy"
    prefix = "terraform/outbound-proxies-state"
  }
}

// ==============================================================================================

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

  prefix     = var.PREFIX
  region     = var.PROVIDER_REGION
  network_id = format("%s%s", var.PREFIX, "vpc")
  subnets    = [module.subnets.subnet_0.name, module.subnets.subnet_1.name]
}

module "nat" {
  source = "./nats"
  prefix = var.PREFIX
  region = var.PROVIDER_REGION

  static_ips = [module.static_ips.static_ip_0.id, module.static_ips.static_ip_1.id]
  net_name   = module.vpc.vpc.name
  subnets    = [module.subnets.subnet_0.name, module.subnets.subnet_1.name]

  depends_on = [module.vpc, module.subnets, module.static_ips]
}
