variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_a_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_b_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_a_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "private_b_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "aws_region" {
  description = "AWS region for the project"
  type        = string
  default     = "eu-central-1"
}

variable "az_a" {
  description = "Availability Zone for subnets A"
  type        = string
  default     = "eu-central-1a"
}

variable "az_b" {
  description = "Availability Zone for subnets B"
  type        = string
  default     = "eu-central-1b"
}