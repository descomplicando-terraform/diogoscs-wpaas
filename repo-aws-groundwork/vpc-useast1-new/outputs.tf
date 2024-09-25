output "vpc_id" {
  description = "VPC ID"
  value       = module.groundwork.vpc_id
}

output "cidr_block" {
  description = "CIRD Block"
  value       = module.groundwork.cidr_block
}