# output all private subnets in the VPC
output "output_private_subnet" {
  value = data.aws_subnets.private.ids
}