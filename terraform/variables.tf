variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "github_token" {
  description = "GitHub token for accessing the repository"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner of the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

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

variable "dockerhub_username" {
  description = "DockerHub username"
  type        = string
}

variable "dockerhub_password" {
  description = "DockerHub password"
  type        = string
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
