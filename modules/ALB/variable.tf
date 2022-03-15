variable "aws_region" {
  description = "define the aws region"
  type        = string
}

variable "name_prefix" {
  description = "the name prefix of the resources"
  type        = string
}

variable "alb_sg_id" {
  description = "id of the pre-created security group for application load balancer"
  type        = string
}

variable "vpc_id" {
  description = "vpc id of the ALB located in"
  type        = string
}