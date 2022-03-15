# output the id of the VPC
output "output_vpc_id" {
  value = aws_vpc.vpc_main.id
}

# output the all the public subnet assigned to the VPC
output "output_public_subnet" {
  value = var.public_subnets
}