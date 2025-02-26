resource "aws_ecs_cluster" "cluster" {
  name = "round6-game-cluster-terraform"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "round6-game-task-terraform"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${var.ecr_repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        {
          name  = "ENV_VAR"
          value = "value"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/round6-game"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "app" {
  name            = "round6-game-service-terraform"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = [var.security_group]
    assign_public_ip = true  
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"  
    container_port   = 80
  }

  depends_on = [var.target_group_arn]
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role-terraform"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_ecr_access" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
