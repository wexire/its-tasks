resource "aws_sns_topic" "its-scaling-topic" {
  name = "its-scaling-topic"
}

resource "aws_sns_topic_subscription" "its-email-subscription" {
  topic_arn = aws_sns_topic.its-scaling-topic.arn
  protocol  = "email"
  endpoint  = var.SUBSCRIPTION_EMAIL
}

resource "aws_autoscaling_notification" "its-asg-notifications" {
  group_names = [
    var.ASG_NAME
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.its-scaling-topic.arn
}

resource "aws_cloudwatch_metric_alarm" "its-scaling-alarm" {
  alarm_name          = "its-scaling-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"
  statistic           = "SampleCount"
  period              = 300
  threshold           = 1
  alarm_description   = "Auto Scaling group scaling event alarm"
  alarm_actions       = [aws_sns_topic.its-scaling-topic.arn]

  dimensions = {
    AutoScalingGroupName = var.ASG_NAME
  }
}