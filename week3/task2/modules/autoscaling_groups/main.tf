resource "aws_autoscaling_group" "its-asg" {
  availability_zones        = var.AZS
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 60

  launch_template {
    id      = var.LT_ID
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "its-asg-attch" {
  autoscaling_group_name = aws_autoscaling_group.its-asg.id
  lb_target_group_arn    = var.TG_ARN
}