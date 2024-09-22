variable "access_key" {
  default = "ASIAW6LTOJXTXMVPPQYX"
}

variable "secret_key" {
  default = "FJtaZAkTm2JzP6wMPUVyVTNMBkTnW5hecgCyoPyN"
}

variable "token" {
  default = "IQoJb3JpZ2luX2VjEHAaCXVzLXdlc3QtMiJHMEUCIQCZBnRpOggrQoqnQ1bMe+NKic27Oyz4tEw5MVw9P6L8MwIgEwXT08TWM8YKC+qnl/GPzze+vKoZxIOtZuNekMWFJIcqvgIIqf//////////ARABGgw0Nzc1MjAzNTA2OTUiDDlfYvaWJFd9rRVlZiqSAlHpwBi5DfH9RE/auvksB+0JiJRgABgZcUSjJpk3GcdnPGhnJ+9tfmsTZwWZy1vmy53IwLDARpNiVZg3YimBBa7OSRhFDDrjohqB3O8gYZgX48aimFgzOyIg/G7QpebfqmGTfzOPZAltrW4u48Hq2/h2IuSc5A0irYgffWkx+FPmPCF/LC+vGdJYcWWwKaNZbSsDOhZdD/iujqOdDs1X8wQOBbj6en6FUt8xVnqS9J7TV6Xzl9p3C91JcyfPuP9WcwdjJalXHeiX03/1spoAcAYRCa6MJCwNhOFD8k0lhpiUwHG3jBCRpZVDGcSJWDy5A3feJhvo5y17tPwPvHmo97Tjiw1j1zrJ2gLwiP2q0OFvmGIwloHBtwY6nQHUa1aWKeFWkwWwLkH8uLkBH/nSCBr4PfyerzO3X/6RKknCUxYUPUZvIcTW6R4NIMWylUZXx8bcohoOQQUMmDW/0nOx319J9KHNUlQVItGLAPa64mgI2Ub+Nwc9fqjq+3eyVgDAbGPPMNbKZ8wL2uePs2sURshr6UPK6PwNyYoImGIrkiIyMRRfwFAy50NGSiT/5U1wYLI6RFSTTnkT"
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