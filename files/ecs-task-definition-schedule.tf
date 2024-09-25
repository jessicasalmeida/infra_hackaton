resource "aws_ecs_task_definition" "ecs_schedule_task_definition" {
  family                   = "schedule-ecs-task"
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
      name         = "schedule"
      image        = aws_ecr_repository.repository_schedule.repository_url
      cpu          = 2048
      memory       = 4000
      essential    = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          "awslogs-group"         = "/ecs/schedule-task"
          "awslogs-region"        = var.region
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" = "schedule"
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
          name  = "APPOINTMENT_COLLECTION_NAME"
          value = "appointment"
        },
        {
          name  = "URL"
          value = aws_apigatewayv2_api.apigtw_health.api_endpoint
        },
        {
          name  = "MQ_CONN_STRING"
          value = "amqp://guest:guest@${aws_lb.rabbit-lb.dns_name}:5672"
        },
        {
          name  = "GOOGLE_MAIL_APP_EMAIL"
          value = "cpspos.sp.gov.br"
        },
        {
          name  = "GOOGLE_MAIL_APP_PASSWORD"
          value = "GRbdp0t79c0JA41U"
        }
      ]
    }
  ])
}
