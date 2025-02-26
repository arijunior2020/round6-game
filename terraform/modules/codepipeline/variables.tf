# Arquivo de variáveis do módulo CodePipeline
variable "github_owner" {
  description = "GitHub owner of the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_token" {
  description = "Github token"
  type = string
}

variable "dockerhub_username" {
  description = "Username dockerhub"
  type = string
}

variable "dockerhub_password" {
  description = "Password dockerhub"
  type = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the CodeStar connection"
  type        = string
}

variable "aws_region" { 
  description = "AWS Region"
  type        = string
}

variable "ecr_repository_name" {
  description = "Nome do repositório ECR onde a imagem será enviada"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL do repositório ECR"
  type        = string
}