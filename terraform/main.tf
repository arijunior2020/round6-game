provider "aws" {
  region = var.aws_region
}

module "ecr" {
  source = "./modules/ecr"
}

module "codebuild" {
  source = "./modules/codebuild"
  ecr_repository_url = module.ecr.repository_url
}

module "ecs" {
  source = "./modules/ecs"
  ecr_repository_url = module.ecr.repository_url
}

module "codepipeline" {
  source = "./modules/codepipeline"
  codebuild_project_name = module.codebuild.project_name
  ecs_service_name = module.ecs.service_name
  ecs_cluster_name = module.ecs.cluster_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}