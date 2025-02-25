resource "aws_ecr_repository" "round6_game" {
    name = "unifor/round6-game"
}

output "ecr_repository_url" {
    value = aws_ecr_repository.round6_game.repository_url
}
