# Arquivo de variáveis do módulo ELB
variable "lb_name" {
    description = "The name of the load balancer"
    type        = string
}

variable "tg_name" {
    description = "The name of the target group"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "public_subnets" {
    description = "A list of public subnets"
    type        = list(string)
}

variable "security_group_id" {
    description = "The ID of the security group"
    type        = string
}