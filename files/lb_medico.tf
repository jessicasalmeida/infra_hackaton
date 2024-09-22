# Load Balancer
resource "aws_lb" "medico-lb" {
  name               = "${var.instance_name}-medico-lb"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.load-balancer-medico-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "default-target-group-medico" {
  name     = "${var.instance_name}-medico-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "ec2-alb-http-listener_medico" {
  load_balancer_arn = aws_lb.medico-lb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.default-target-group-medico]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group-medico.arn
  }
}