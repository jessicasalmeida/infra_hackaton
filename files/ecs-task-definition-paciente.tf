resource "aws_ecs_task_definition" "ecs_paciente_task_definition" {
  family                   = "paciente-ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = var.labRole
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  container_definitions = jsonencode([
    {
      name         = "paciente"
      image        = aws_ecr_repository.repository_paciente.repository_url
      cpu          = 2048
      memory       = 4000
      essential    = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/paciente-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "paciente-service"
        }
      }
      environment = [
        {
          name  = "DB_CONN_STRING"
          value = var.mongodb
        },
        {
          name  = "DB_NAME"
          value = "health"
        },
        {
          name  = "PACIENTE_COLLECTION_NAME"
          value = "paciente"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.apigtw_health.api_endpoint
        },
        {
          name = "MQ_CONN_STRING"
          value = "amqp://guest:guest@${aws_lb.rabbit-lb.dns_name}:5672"
        },
        {
          name = "AWS_REGION"
          value = var.region
        },
        {
          name = "COGNITO_USER_POOL_ID"
          value = aws_cognito_user_pool.paciente_pool.id
        },
        {
          name = "AWS_ACCESS_KEY_ID"
          value = var.access_key
        },
        {
          name = "AWS_SECRET_ACCESS_KEY"
          value = var.secret_key
        },
        {
          name = "TOKEN"
          value = var.token
        },
        {
          name = "SCHEDULE_SERVER"
          value = "http://${aws_lb.schedule-lb.dns_name}"
        }
      ]
    }
  ])
}