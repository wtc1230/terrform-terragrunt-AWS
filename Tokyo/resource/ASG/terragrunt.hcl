locals {
  # Automatically load environment-level variables
  region_vars   = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))

# Extract out common variables for reuse
  aws_region    = local.region_vars.locals.aws_region
  name_prefix   = local.account_vars.locals.name_prefix
}

# State the dependencies
dependencies {
  paths = ["../VPC", "../SG", "../ALB"]
}

# Dependency output from other modules
dependency "sg" {
  config_path = "../SG"
}

dependency "alb" {
  config_path = "../ALB"
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ASG"
}

inputs = {
  name_prefix             = local.name_prefix
  asg_sg_id               = dependency.sg.outputs.output_alb_sg_id
  template_ami            = "ami-078c2489a814198ce"
  template_instance_type  = "t3.micro"
  instance_keyname        = "jessie-key-tokyo"
  alb_tg_arn              = dependency.alb.outputs.output_alb_tg_arn
  alb_tg_arn_suffix       = dependency.alb.outputs.output_alb_tg_arn_suffix
  alb_arn_suffix          = dependency.alb.outputs.output_alb_arn_suffix
}

