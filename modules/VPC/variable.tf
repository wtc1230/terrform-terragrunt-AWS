variable "aws_region" {
  description = "define the aws region"
  type        = string
}

variable "name_prefix" {
  description = "the name prefix of the resources"
  type        = string
}

variable "vpc_cidr" {
  description = "cidr block of the customized VPC"
  type        = string

}

variable "public_subnets" {
  description = "public subnets of the customized VPC"
  type        = list
}

variable "private_subnets" {
  description = "private subnets of the customized VPC"
  type        = list
}