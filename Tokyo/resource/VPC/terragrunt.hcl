locals {
  # Automatically load environment-level variables
  region_vars   = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_vars  = read_terragrunt_config(find_in_parent_folders("account.hcl"))

# Extract out common variables for reuse
  aws_region    = local.region_vars.locals.aws_region
  name_prefix   = local.account_vars.locals.name_prefix
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/VPC"
}

inputs = {
  aws_region      = local.aws_region
  name_prefix     = local.name_prefix
  vpc_cidr        = "10.2.0.0/16"
  public_subnets  = ["10.2.0.0/18", "10.2.64.0/18"]
  private_subnets = ["10.2.128.0/18", "10.2.192.0/18"]
}