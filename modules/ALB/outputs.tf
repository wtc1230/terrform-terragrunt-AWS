# output the arn of the target group
output "output_alb_tg_arn" {
  value = aws_lb_target_group.alb_tg.arn
}

# output the arn suffix of the target group
output "output_alb_tg_arn_suffix" {
  value = aws_lb_target_group.alb_tg.arn_suffix
}

# output the arn suffix of the ALB
output "output_alb_arn_suffix" {
  value = aws_lb.alb_main.arn_suffix
}