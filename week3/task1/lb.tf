resource "aws_lb" "its-lb" {
  name               = "its-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.its-lb-sg.id]
  subnets            = [var.SUBNET_A, var.SUBNET_B]

  tags = {
    Name = "its-lb"
  }
}

resource "aws_lb_listener" "its-lb-listener" {
  load_balancer_arn = aws_lb.its-lb.arn
  port              = var.LISTENER_PORT
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.its-lb-tg.arn
  }
}

resource "aws_lb_target_group" "its-lb-tg" {
  name     = "its-lb-tg"
  port     = var.LISTENER_PORT
  protocol = "HTTP"
  vpc_id   = var.DEFAULT_VPC
}

output "LoadBalancerURL" {
  value = "http://${aws_lb.its-lb.dns_name}:${var.LISTENER_PORT}"
}