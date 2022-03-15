# create a listener for ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# create a target group
resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.name_prefix}-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# create a ALB
resource "aws_lb" "alb_main" {
  # the name of ALB must unique within your AWS account
  name               = "${var.name_prefix}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  # assign all public subnets in the VPC to this ALB
  subnets            = [for subnet in data.aws_subnets.public.ids : subnet]
}

# find all subnets with tag subnet_type:public
data "aws_subnets" "public" {
  filter {
    name   = "tag:subnet_type"
    values = ["public"]
  }
}
