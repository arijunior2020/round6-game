# Descrição: Arquivo responsável por criar as saídas dos módulos
output "project_name" {
  value = aws_codebuild_project.project.name
}