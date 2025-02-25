resource "aws_ecs_cluster" "round6_game_cluster" {
    name = "round6-game-cluster"
}

resource "aws_ecs_task_definition" "round6_game_task" {
    family                   = "round6-game-task"
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = "256"
    memory                   = "512"

    container_definitions = jsonencode([{
        name  = "round6-game"
        image = var.ecr_repo_url
        portMappings = [{
        containerPort = 80
        hostPort      = 80
        }]
    }])
}

resource "aws_ecs_service" "round6_game_service" {
    name            = "round6-game-service"
    cluster         = aws_ecs_cluster.round6_game_cluster.id
    task_definition = aws_ecs_task_definition.round6_game_task.arn
    desired_count   = 1
}
