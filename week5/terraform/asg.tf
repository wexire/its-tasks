resource "aws_appautoscaling_target" "its-autoscaling-target" {
  max_capacity = 3
  min_capacity = 1
  resource_id = "service/${aws_ecs_cluster.its-ecs.name}/${aws_ecs_service.its-ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "its-autoscaling-policy" {
  name = "its-autoscaling-policy"
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.its-autoscaling-target.id
  scalable_dimension = aws_appautoscaling_target.its-autoscaling-target.scalable_dimension
  service_namespace = aws_appautoscaling_target.its-autoscaling-target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}