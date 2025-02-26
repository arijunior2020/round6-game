# Arquivo principal do módulo CodePipeline

data "aws_caller_identity" "current" {}

# Recurso CodePipeline
resource "aws_codepipeline" "pipeline" {
  name     = "round6-game-pipeline-terraform"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = "${var.github_owner}/${var.github_repo}"
        BranchName       = "main"
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
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "ECS"
      version          = "1"
      input_artifacts  = ["build_output"]
      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }
}

# Recurso IAM Role para o CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role-terraform"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "codepipeline-task-execution-role-terraform"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy_attachment" "ecs_ecr_access" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy_attachment" "codepipeline_ecs_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_policy_attachment" "ecs_full_access" {
  name       = "ecs-full-access-attachment"
  roles      = [aws_iam_role.codepipeline_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy" "codepipeline_custom_policy" {
  name = "codepipeline-custom-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Permissões para acessar o S3 (artefatos da pipeline)
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::round6-game-artifact-store-terraform",
          "arn:aws:s3:::round6-game-artifact-store-terraform/*"
        ]
      },
      
      # Permissões para CodeStar (integração com GitHub)
      {
        Effect = "Allow",
        Action = [
          "codestar-connections:UseConnection"
        ],
        Resource = var.codestar_connection_arn
      },

      # Permissões para CodeBuild
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ],
        Resource = "arn:aws:codebuild:${var.aws_region}:${data.aws_caller_identity.current.account_id}:project/${var.codebuild_project_name}"
      },

      # 🔥 **Permissões para ECS (Correção)** 🔥
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeServices",
          "ecs:UpdateService",
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:ListClusters",
          "ecs:ListServices"
        ],
        Resource = [
          "arn:aws:ecs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:service/${var.ecs_cluster_name}/${var.ecs_service_name}",
          "arn:aws:ecs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:task-definition/*"
        ]
      },

      # 🔥 **Permissões para IAM (caso precise criar novas definições de execução no ECS)** 🔥
      {
        Effect = "Allow",
        Action = [
          "iam:PassRole"
        ],
        Resource = "*"
        Condition = {
          StringEqualsIfExists = {
            "iam:PassedToService" = "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}

# Anexando políticas ao IAM Role do CodePipeline
resource "aws_iam_role_policy_attachment" "codepipeline_codestar_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeStarFullAccess"
}

# Criando bucket S3 para armazenar os artefatos da pipeline
resource "aws_s3_bucket" "artifact_store" {
  bucket = "round6-game-artifact-store-terraform"
}
