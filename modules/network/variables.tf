variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "private_a_cidr" {
  description = "CIDR block for private subnet A"
  type        = string
}

variable "private_b_cidr" {
  description = "CIDR block for private subnet B"
  type        = string
}

variable "az_a" {
  description = "Availability Zone for subnets A"
  type        = string
}

variable "az_b" {
  description = "Availability Zone for subnets B"
  type        = string
}