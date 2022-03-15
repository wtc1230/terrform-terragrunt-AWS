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
  paths = ["../VPC", "../SG"]
}

# Dependency output from other modules
dependency "vpc" {
  config_path = "../VPC"
}

dependency "sg" {
  config_path = "../SG"
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ALB"
}

inputs = {
  aws_region      = local.aws_region
  name_prefix     = local.name_prefix
  vpc_id          = dependency.vpc.outputs.output_vpc_id
  alb_sg_id       = dependency.sg.outputs.output_alb_sg_id
}
