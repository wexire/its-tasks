resource "aws_ecs_cluster" "its-ecs" {
  name = "its-ecs"
}

resource "aws_ecs_task_definition" "its-ecs-tdef" {
  family = "its-ecs-tdef"
  cpu    = 1024
  memory = 3072
  container_definitions = jsonencode([
    {
      name  = var.CONTAINER_NAME
      image = var.IMAGE_URL
      environment = [
        {
          name  = "DATABASE_URL",
          value = "postgresql://${var.USER_NAME}:${var.USER_PASSWORD}@${aws_db_instance.its-db-i.endpoint}/${var.DB_NAME}"
        },
        {
          name  = "DJANGO_ALLOWED_HOSTS",
          value = "*"
        },
        {
          name  = "DJANGO_SUPERUSER_PASSWORD",
          value = var.DJANGO_SUPERUSER_PASSWORD
        },
        {
          name  = "DJANGO_SUPERUSER_USERNAME",
          value = var.DJANGO_SUPERUSER_USERNAME
        },
        {
          name  = "DJANGO_SUPERUSER_EMAIL",
          value = var.DJANGO_SUPERUSER_EMAIL
        }
      ],
      essential = true
      portMappings = [
        {
          containerPort = var.WEB_PORT
          hostPort      = var.WEB_PORT
        }
      ]
    }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.its-exec-role.arn
  depends_on               = [aws_db_instance.its-db-i]
}

resource "aws_ecs_service" "its-ecs-service" {
  name            = "its-ecs-service"
  cluster         = aws_ecs_cluster.its-ecs.arn
  task_definition = aws_ecs_task_definition.its-ecs-tdef.arn
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = [for subnet in aws_subnet.its-sub-pub : subnet.id]
    security_groups  = [aws_security_group.its-container-sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.its-tg.arn
    container_name   = var.CONTAINER_NAME
    container_port   = var.WEB_PORT
  }
}