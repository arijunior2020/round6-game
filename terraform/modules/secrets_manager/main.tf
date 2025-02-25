resource "aws_secretsmanager_secret" "github_token" {
    name = "github-access-token"
}

resource "aws_secretsmanager_secret_version" "github_token_value" {
    secret_id     = aws_secretsmanager_secret.github_token.id
    secret_string = "SEU_GITHUB_PERSONAL_ACCESS_TOKEN"
}

output "github_token_arn" {
    value = aws_secretsmanager_secret.github_token.arn
}
