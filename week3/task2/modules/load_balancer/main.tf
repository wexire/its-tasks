resource "aws_lb" "its-lb" {
  name               = "its-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.LB_SG_ID]
  subnets            = var.SUBNETS

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

  tags = {
    Name = "its-lb-tg"
  }
}