# output the id of the ALB security group
output "output_alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

# output the id of the ASG security group
output "output_lc_sg_id" {
  value = aws_security_group.template_sg.id
}