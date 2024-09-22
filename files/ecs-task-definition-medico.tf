resource "aws_ecs_task_definition" "ecs_medico_task_definition" {
  family                   = "medico-ecs-task"
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
      name         = "medico"
      image        = aws_ecr_repository.repository_medico.repository_url
      cpu          = 1024
      memory       = 2048
      essential    = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/medico-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "medico-service"
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
          name  = "DOCTOR_COLLECTION_NAME"
          value = "doctor"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.apigtw_health.api_endpoint
        },
        {
          name = "MQ_CONN_STRING"
          value = "amqp://guest:guest@${aws_lb.rabbit-lb.dns_name}:5672"
        }
      ]
    }
  ])
}