variable "vpc_cidr_block" {
  type = string
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_name" {
  type = string
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "subnet_availability_zones" {
  type = list(string)
}

variable "subnet_map_public_ip_on_launch" {
  type    = bool
  default = false
}

variable "subnet_name_prefix" {
  type = string
}

variable "subnet_tags" {
  type    = map(string)
  default = {}
}
