# create launch configuration for Auto Scaling Group
resource "aws_launch_configuration" "asg_lc" {
  image_id        = var.template_ami
  instance_type   = var.template_instance_type
  key_name        = var.instance_keyname
  security_groups = [var.asg_sg_id]
}

# create a auto-scaling policy
resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "${var.name_prefix}-ASG-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg_main.name

  target_tracking_configuration {
    predefined_metric_specification {
      # scaling with maintaining a `target value` request per target
      # in this example is maintaining 1 request per target
      predefined_metric_type  = "ALBRequestCountPerTarget"
      resource_label          = "${var.alb_arn_suffix}/${var.alb_tg_arn_suffix}"
    }

    target_value = 1.0
  }
}

# create ASG
resource "aws_autoscaling_group" "asg_main" {
  name                  = "${var.name_prefix}-ASG"
  # assign all private subnets in the VPC to this ASG
  vpc_zone_identifier   = data.aws_subnets.private.ids
  target_group_arns     = toset([var.alb_tg_arn])
  launch_configuration  = aws_launch_configuration.asg_lc.name
  desired_capacity      = 1
  max_size              = 1
  min_size              = 1
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:subnet_type"
    values = ["private"]
  }
}