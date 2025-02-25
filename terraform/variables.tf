variable "aws_region" {
    default = "us-east-1"
}

variable "github_owner" {
    description = "Nome do usuário ou organização no GitHub"
}

variable "github_repo" {
    description = "Nome do repositório do GitHub"
}

variable "github_branch" {
    default     = "main"
    description = "Branch do repositório GitHub a ser usado no pipeline"
}
