output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = aws_subnet.this[*].id
}

output "subnet_cidrs" {
  description = "CIDR blocks of the created subnets"
  value       = aws_subnet.this[*].cidr_block
}
