variable "access_key" {
  default = "ASIAW6LTOJXT7B2UBX5Z"
}

variable "secret_key" {
  default = "WOtF1PZlaK91Bp/nb0UL2ULAGY0XQe70OslgBMNL"
}

variable "token" {
  default = "IQoJb3JpZ2luX2VjEKj//////////wEaCXVzLXdlc3QtMiJGMEQCIAu5uQKvd2Aygq5ElPakBB9ncvsLZoHz2q2fo5KAtAkoAiBcvMDt41N7M+O3637Ha8ourr7xJHVXJm5b0+ph9Y0VfSq+Agjg//////////8BEAEaDDQ3NzUyMDM1MDY5NSIMGwp/GN6N5TuTt4KsKpIC3i9Ff8tJpeSKLGGLVaR14fFLLMY/1i3kuzoaMEkYSJClzpolzFZMLO0g2H2fsWfEMq9x2Wruz2KchYbECT90H8SNglSy51wC3PYFNF1Su6HhAjvYk3l5cRC72YDXRyiscA0zcBZa74ST0hXXhZy6niCUNyAoDSuIPMC+n4yOhOZAGQQX/Leu7ZIhSUm0MSHPEplrkqOa5zMPUk+puCXpDECA8OMMY/6xNWID/xXo6oJoGxQF0SXfbrqxIQQFr26vf580IqqI4INMVxJE/ktopkhoJJ38itlRXJWrGaEaZzt7OvHJPjr8zwzAVW9E122Oih8st08gyku8jOpfAaCzq8CmlyYOVQ2Rr2G6GCrxt/pqVzD+ks23BjqeAYJkXw0G7Uzk/LzCQIvVLT92vj4W8PzQac9dhI/RYLqwqe7YMj5PqK8rLQ2QcMvfHkEr7HrUhMya+jOtH/bIWauq6UzD57DXfsuEjEVszAIIRXtIHu6D4xORlxlXyF6usZgV1NMSih787HE7aeVN3D814NbMxz6jmOSVB5hJzFj5gIhAxxTkxPacn3VjFCYNLV68hKAO14MmPUWGjsIE"
}

variable "labRole" {
  default = "arn:aws:iam::477520350695:role/LabRole"
}

variable "principalArn" {
  default = "arn:aws:iam::477520350695:role/voclabs"
}

variable "accountId" {
  default = "477520350695"
}

variable "ecsTaskDefinition" {
  default = "arn:aws:iam::477520350695:role/ecsTaskExecutionRole"
}

variable "mongodb" {
  default = "mongodb+srv://admin:fiap_fase3@restaurante-prod-cluste.rkutlhb.mongodb.net/?retryWrites=true&w=majority&appName=restaurante-prod-cluster"
}

variable "policyArn" {
  default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}
variable "sgId" {
  default = "sg-01379b3d488d94d68"
}

variable "accessConfig" {
  default = "API_AND_CONFIG_MAP"
}

variable "nodeName" {
  default = "node-fiap"
}

variable "region" {
  default = "us-east-1"
}

# networking
variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# load balancer
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

variable "amis" {
  description = "Which AMI to spawn."
  default     = {
    us-east-1 = "ami-05fa00d4c63e32376"
    us-east-2 = "ami-0568773882d492fc8"
  }
}
variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  description = "Name of the instance"
  default     = "health"
}


# key pair - Location to the SSH Key generate using openssl or ssh-keygen or AWS KeyPair
variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "~/.ssh/aws/aws_key.pub"
}


# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EKS)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EKS)"
  default     = "3"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EKS)"
  default     = "1"
}
variable "queue_con" {
  description = "QUEUE CONNECTION"
  default = "amqp://guest:guest@localhost:5672"
}