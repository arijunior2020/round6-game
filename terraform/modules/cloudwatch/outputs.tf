# Recursos de saída do módulo CloudWatch:
output "log_group_name" {
  value = aws_cloudwatch_log_group.ecs_log_group.name
}