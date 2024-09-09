provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  name                 = var.vpc_name
  tags                 = var.vpc_tags
}