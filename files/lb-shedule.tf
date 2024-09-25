# Load Balancer
resource "aws_lb" "schedule-lb" {
  name               = "${var.instance_name}-lb-schedule"
  load_balancer_type = "application"
  internal           = true
  security_groups    = [aws_security_group.load-balancer-schedule-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

# Target group
resource "aws_alb_target_group" "schedule-target-group" {
  name     = "${var.instance_name}-schedule-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_alb_listener" "schedule-alb-http-listener" {
  load_balancer_arn = aws_lb.schedule-lb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.schedule-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.schedule-target-group.arn
  }
}