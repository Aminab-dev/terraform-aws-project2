output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs ordered A, B"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs ordered A, B"
  value       = module.network.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs ordered A, B"
  value       = module.network.nat_gateway_ids
}