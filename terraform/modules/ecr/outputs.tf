# Arquivo de saídas do módulo ECR
output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.repo.name
}
