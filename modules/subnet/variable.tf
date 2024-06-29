variable "vpc_id" {
  description = "The ID of the VPC where the subnets will be created"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones where the subnets will be created"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether to map a public IP on launch"
  type        = bool
  default     = false
}

variable "name_prefix" {
  description = "Prefix for subnet names"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the subnets"
  type        = map(string)
  default     = {}
}

variable "create_subnets" {
  description = "Flag to control the creation of subnets"
  type        = bool
  default     = true
}
