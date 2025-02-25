variables.tf
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