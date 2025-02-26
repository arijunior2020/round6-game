# Arquivo de outputs do módulo vpc
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "Lista de IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "security_group_id" {
  value = aws_security_group.main.id
}

