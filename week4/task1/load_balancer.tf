resource "aws_lb" "its-lb" {
  name               = "its-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.its-lb-sg.id]
  subnets            = [aws_subnet.its-sub-pub-1.id, aws_subnet.its-sub-pub-2.id]

  tags = {
    Name = "its-lb"
  }
}

resource "aws_lb_target_group" "its-tg" {
  name     = "its-tg"
  port     = var.LISTENER_PORT
  protocol = "HTTP"
  vpc_id   = aws_vpc.its-vpc.id
  tags = {
    Name = "its-tg"
  }
}

resource "aws_lb_target_group_attachment" "its-tg-attach" {
  count = length(aws_instance.its-web)
  target_group_arn = aws_lb_target_group.its-tg.arn
  target_id        = aws_instance.its-web[count.index].id
  port             = var.LISTENER_PORT
}

resource "aws_lb_listener" "its-lb-listener" {
  load_balancer_arn = aws_lb.its-lb.arn
  port              = var.LISTENER_PORT

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.its-tg.arn
  }
}