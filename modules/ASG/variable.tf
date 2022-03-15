variable "name_prefix" {
  description = "the name prefix of the resources"
  type        = string
}

variable "asg_sg_id" {
  description = "id of the pre-created security group for the launch configuration"
  type        = string
}

variable "template_ami" {
  description = "ami id for the launch configuration"
  type        = string
}

variable "template_instance_type" {
  description = "instance type of the launch configuration"
  type        = string
}

variable "instance_keyname" {
  description = "key pair name of the instance created by ASG"
  type        = string
}

variable "alb_tg_arn" {
  description = "arn of the target group"
  type        = string
}

variable "alb_tg_arn_suffix" {
  description = "arn suffix of the target group"
  type        = string
}

variable "alb_arn_suffix" {
  description = "arn suffix of ALB"
  type        = string
}