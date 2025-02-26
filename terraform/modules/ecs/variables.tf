# Arquivo responsável por definir as variáveis que serão utilizadas no módulo ECS
variable "ecr_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "subnets" {
  description = "A list of subnets"
  type        = list(string)
}

variable "security_group" {
  description = "The security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group"
  type        = string
}