resource "aws_lb" "its-lb" {
  name               = "its-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.its-lb-sg.id]
  subnets            = [for subnet in aws_subnet.its-sub-pub : subnet.id]

  tags = {
    Name = "its-lb"
  }
}

resource "aws_lb_target_group" "its-tg" {
  name     = "its-tg"
  port     = var.WEB_PORT
  protocol = "HTTP"
  vpc_id   = aws_vpc.its-vpc.id
  target_type = "ip"
  tags = {
    Name = "its-tg"
  }
}

resource "aws_lb_listener" "its-lb-listener" {
  load_balancer_arn = aws_lb.its-lb.arn
  port              = var.WEB_PORT

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.its-tg.arn
  }
}