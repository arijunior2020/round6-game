# Descrição: Arquivo responsável por criar as variáveis do módulo
output "pipeline_name" {
  value = aws_codepipeline.pipeline.name
}