resource "aws_ecr_repository" "repository_schedule" {
  name = "schedule"
}

resource "aws_ecr_repository" "repository_medico" {
  name = "medico"
}

resource "aws_ecr_repository" "repository_paciente" {
  name = "paciente"
}

resource "aws_ecr_repository" "repository_rabbit" {
  name = "rabbit"
}

