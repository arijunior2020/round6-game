# Arquivo de variáveis do módulo VPC
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones"
  type        = list(string)
}