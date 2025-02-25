output "ecr_repository_url" {
    value = module.ecr.ecr_repository_url
}

output "codepipeline_url" {
    value = module.codepipeline.codepipeline_url
}

output "ecs_service_url" {
    value = module.ecs.ecs_service_url
}
