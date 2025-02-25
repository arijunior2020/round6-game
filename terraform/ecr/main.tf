resource "aws_ecr_repository" "repo" {
  name = "round6-game"
}

output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}