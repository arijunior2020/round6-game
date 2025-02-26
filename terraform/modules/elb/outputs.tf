# Arquivo de saídas do módulo ELB
output "lb_arn" {
    description = "The ARN of the load balancer"
    value       = aws_lb.app_lb.arn
}

output "tg_arn" {
    description = "The ARN of the target group"
    value       = aws_lb_target_group.app_tg.arn
}
output "dns_name" {
    value = aws_lb.your_load_balancer.dns_name
}