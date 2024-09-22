variable "access_key" {
  default = "AKIAZMJCF4BFT3EYUD5D"
}

variable "secret_key" {
  default = "CoqF1jVcWtWt2otSUatb7/8tRD3klRHllHRL5GF8"
}

variable "token" {
  default = "IQoJb3JpZ2luX2VjEBAaCXVzLXdlc3QtMiJGMEQCIEWvSdM5jiHMKi21Hn8MFnN5qSTL8iKIpz9wARKoRDO+AiAsT85Ax67QcH/izi4yF1pVr3ypTRltoHWkZn4FWgWfVyq1Agg5EAEaDDI0ODAyODA0OTQwMyIMWv14JM6Yf+5f30d4KpICs1lRFbg1pA//zzE4s+r108YranL1D/jKyzTcwbIP39hkuEjRyoihvO9kP99G4Tj2tXQIr+KxYqz+LPjUu65dU9pj7UXw2fS0MKHccIoWp5IBM7hPzS/PZdEVgq9SnIwcHzWkKkh2SaoIry7hSpN9w9/E7iaV4luqtJb7IPaUgk9O9XEoX3ap/M+vVPMPM3IvDz2/dwMs/YJDf7xYbpJ0ScIObtyLP7xUZOI05t6/AHpsBQBPHm+rBfSeDzBAZeGTpfoqRxXWM2gz5uSxQ/qMlQAGjMwpGohkJlArl4oSPrJJIo2ttUnF6VnecIuzfKTp7bs0G58hKhonBzFKaj2qe2ka/oGZlA7/XF+cKPaLeL3I/zDhxPO2BjqeAewyQVFIPJwzfbedIT+dQ78RVmixhIo+aEGtaO4RnOvImHdALGEyoDBBjZ+Me/4nK1ggfxuODlpnxuIZJnFzOLJ1iE0MeZcACDhdfQok7KwmfKyvhd2fCScyBtjp3QEmblG+XIHbin0F8EyBmQF0pxlFoC9hgNI4I1rdLTPRHZgmWDy8ylrq4aIxKohh88vEXC6H8mNGMN64abmD4+qh"
}

variable "labRole" {
  default = "arn:aws:iam::477520350695:role/ecs_task_function"
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

variable "eks_instance_name" {
  description = "Name of the EKS instance"
  default     = "restaurante-eks"
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