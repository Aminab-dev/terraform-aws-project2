output "vpc_id" {
  description = "ID of the project VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs ordered A, B"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "private_subnet_ids" {
  description = "Private subnet IDs ordered A, B"
  value = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs ordered A, B"
  value = [
    aws_nat_gateway.nat_a.id,
    aws_nat_gateway.nat_b.id
  ]
}