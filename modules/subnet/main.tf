resource "aws_subnet" "this" {
  count = var.create_subnets ? length(var.subnet_cidrs) : 0

  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      "Name" = "${var.name_prefix}-${count.index}"
    },
    var.tags
  )
}
