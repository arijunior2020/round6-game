variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "security_group" {
  description = "Security group ID"
  type        = string
}