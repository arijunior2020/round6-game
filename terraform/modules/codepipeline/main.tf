resource "aws_codepipeline" "round6_game_pipeline" {
    name     = "round6-game-pipeline"
    role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
    location = var.s3_bucket
    type     = "S3"
    }

    stage {
        name = "Source"

    action {
        name             = "GitHub_Source"
        category         = "Source"
        owner            = "ThirdParty"
        provider         = "GitHub"
        version          = "1"
        output_artifacts = ["source_output"]

        configuration = {
            Owner      = var.github_owner
            Repo       = var.github_repo
            Branch     = var.github_branch
            OAuthToken = var.github_token
        }
    }
    }

    stage {
        name = "Build"

        action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source_output"]
        output_artifacts = ["build_output"]
        version          = "1"

        configuration = {
            ProjectName = var.codebuild_project_name
        }
        }
    }
}
