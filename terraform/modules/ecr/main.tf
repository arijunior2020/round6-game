# Recurso para criação de um repositório no ECR
resource "aws_ecr_repository" "repo" {
  name = "round6-game-terraform"
}