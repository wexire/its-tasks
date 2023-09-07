resource "aws_autoscaling_group" "its-asg" {
  availability_zones        = [var.AZ1, var.AZ2]
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.its-lt.id
    version = "$Latest"
  }

  tags = {
    Name = "${var.env}-asg"
  }
}

resource "aws_autoscaling_attachment" "its-asg-attch" {
  autoscaling_group_name = aws_autoscaling_group.its-asg.id
  lb_target_group_arn    = aws_lb_target_group.its-lb-tg.arn
}