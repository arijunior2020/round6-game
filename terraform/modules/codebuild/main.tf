# Arquivo responsável por criar o CodeBuild Project
resource "aws_codebuild_project" "project" {
  name          = var.codebuild_project_name
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true

    environment_variable {
      name  = "DOCKERHUB_USERNAME"
      value = var.dockerhub_username
    }
    environment_variable {
      name  = "DOCKERHUB_PASSWORD"
      value = var.dockerhub_password
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec.yml")
  }
}

# Arquivo responsável por criar o IAM Role para o CodeBuild
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role-terraform"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

# Arquivo responsável por criar as políticas de permissões para o CodeBuild
resource "aws_iam_role_policy" "codebuild_custom_policy" {
  name = "codebuild-custom-policy-terraform"
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Permissões para S3 (acesso ao bucket de artefatos)
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::round6-game-artifact-store-terraform",
          "arn:aws:s3:::round6-game-artifact-store-terraform/*"
        ]
      },
      
      # Permissões para logs do CloudWatch
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        Resource = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.codebuild_project_name}",
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.codebuild_project_name}:*"
        ]
      }
    ]
  })
}

# Anexando políticas de permissões ao IAM Role do CodeBuild
resource "aws_iam_role_policy_attachment" "codebuild_policy_ecr" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Anexando políticas de permissões ao IAM Role do CodeBuild
resource "aws_iam_role_policy_attachment" "codebuild_policy_codebuild" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}
