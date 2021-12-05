resource "aws_autoscaling_group" "phonebook-app" {
  name = "auto-scaled-app"
  desired_capacity = 2
  max_size = 10
  min_size = 2

  availability_zones = ["us-east-1a", "us-east-1b"]

  target_group_arns = [aws_lb_target_group.tg-ph.arn]

  health_check_grace_period = 60
  protect_from_scale_in = false

  launch_template {
    id = aws_launch_template.app_node.id
    version = "$latest"
  }

  tag {
    key = "asg"
    propagate_at_launch = true
    value = "auto-scaled-app"
  }
}

resource "aws_autoscaling_policy" "as-app" {
  autoscaling_group_name = aws_autoscaling_group.phonebook-app.name
  name = "requests_count_scaling_policy"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    target_value = 50

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = format("%s/%s", aws_lb.public_alb.arn_suffix, aws_lb_target_group.tg-ph.arn_suffix)
    }
  }
}