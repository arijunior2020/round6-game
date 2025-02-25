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
  region  = var.aws_region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  availability_zones  = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"
}

module "codebuild" {
  source             = "./modules/codebuild"
  ecr_repository_url = module.ecr.repository_url
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
}

module "ecs" {
  source             = "./modules/ecs"
  ecr_repository_url = module.ecr.repository_url
  aws_region         = var.aws_region
  subnets            = module.vpc.private_subnets
  security_group     = module.vpc.security_group_id
  target_group_arn   = module.elb.tg_arn
}

module "codestar" {
  source          = "./modules/codestar"
  connection_name = "github-connection"
}

module "codepipeline" {
  source                = "./modules/codepipeline"
  ecr_repository_name   = module.ecr.repository_name
  github_token          = var.github_token
  github_owner          = var.github_owner
  github_repo           = var.github_repo
  codebuild_project_name = module.codebuild.project_name
  aws_region            = "us-east-1"
  ecs_service_name      = module.ecs.service_name
  ecs_cluster_name      = module.ecs.cluster_name
  dockerhub_username    = var.dockerhub_username
  dockerhub_password    = var.dockerhub_password
  codestar_connection_arn = module.codestar.codestar_connection_arn
  depends_on = [module.codestar]
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "elb" {
  source           = "./modules/elb"
  lb_name          = "round6-game-alb"
  tg_name          = "round6-game-tg"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  security_group_id = module.vpc.security_group_id
}