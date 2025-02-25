terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

module "ecr" {
    source = "./modules/ecr"
}

module "ecs" {
    source       = "./modules/ecs"
    ecr_repo_url = module.ecr.ecr_repository_url
}

module "s3" {
    source = "./modules/s3"
}

module "iam" {
    source = "./modules/iam"
}

module "secrets_manager" {
    source = "./modules/secrets_manager"
}

module "codepipeline" {
    source                 = "./modules/codepipeline"
    s3_bucket              = module.s3.s3_bucket_id
    github_repo            = var.github_repo
    github_owner           = var.github_owner
    github_branch          = var.github_branch
    github_token           = module.secrets_manager.github_token_arn
    codebuild_project_name = module.ecs.codebuild_project_name
}
