# Recurso para criação de um grupo de logs no CloudWatch
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/round6-game-terraform"
  retention_in_days = 7
}