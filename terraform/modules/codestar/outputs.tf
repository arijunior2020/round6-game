# Arquivo de saída do módulo CodeStar
output "codestar_connection_arn" {
    value = aws_codestarconnections_connection.github_connection.arn
}
