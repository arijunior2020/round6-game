output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "codebuild_project_name" {
  value = module.codebuild.project_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}