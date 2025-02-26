# Arquivo de variáveis do módulo CodeBuild
variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_password" {
  description = "Docker Hub password"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "aws_region" {
  description = "Região da AWS"
  type        = string
}

variable "codebuild_project_name" {
  description = "Nome do projeto CodeBuild"
  type        = string
}

variable "ecr_repository_name" {
  description = "Nome do repositório ECR"
  type        = string
}