module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  name                 = var.vpc_name
  tags                 = var.vpc_tags
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id                  = module.vpc.vpc_id
  subnet_cidrs            = var.subnet_cidrs
  availability_zones      = var.subnet_availability_zones
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  name_prefix             = var.subnet_name_prefix
  tags                    = var.subnet_tags
}
