terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.88.0"
    }
  }
}

provider "aws" {
  profile = "aws-pipeline"
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "ecr" {
  source = "./modules/ecr"
}

module "codebuild" {
  source = "./modules/codebuild"
  ecr_repository_url = module.ecr.repository_url
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
}

module "ecs" {
  source = "./modules/ecs"
  ecr_repository_url = module.ecr.repository_url
  aws_region         = var.aws_region
  subnets            = module.vpc.private_subnets
  security_group     = module.vpc.security_group_id
}

module "codepipeline" {
  source = "./modules/codepipeline"
  github_token       = var.github_token
  github_owner       = var.github_owner
  github_repo        = var.github_repo
  codebuild_project_name = module.codebuild.project_name
  ecs_service_name   = module.ecs.service_name
  ecs_cluster_name   = module.ecs.cluster_name
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}