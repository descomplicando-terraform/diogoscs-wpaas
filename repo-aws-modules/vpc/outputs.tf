output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "cidr_block" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "subnets" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.cidr_block
}
