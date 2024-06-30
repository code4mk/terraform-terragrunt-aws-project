terraform {
  source = "../../terraform//stage"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  vpc_cidr_block             = "10.0.0.0/16"
  vpc_enable_dns_hostnames   = true
  vpc_enable_dns_support     = true
  vpc_name                   = "stage-vpc"
  vpc_tags                   = {
    "Environment" = "stage"
  }

  subnet_cidrs               = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_availability_zones  = ["us-west-2a", "us-west-2b"]
  subnet_map_public_ip_on_launch = true
  subnet_name_prefix         = "stage-subnet"
  subnet_tags                = {
    "Environment" = "stage"
  }
}
