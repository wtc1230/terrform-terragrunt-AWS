/*
Creator: Jessie
Date: 17 Feb 2022

Assignment Scenario:
Company Alpha is a global company that has two regional offices - Sydney and Tokyo.
The CTO of the company would like to migrate their on-premises application to AWS Cloud.
He would like to have an ALB and an Auto Scaling Group Empty LAMP Server.
He wants to also have a customized VPC instead of the default one.
This setup needs to be deployed in customer’s regional offices.
Please create the Terraform module and Terragrunt code
*/

# root terragrunt configuration

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      region = "${local.aws_region}"
      # Only these AWS Account IDs may be operated on by this template
      allowed_account_ids = ["${local.account_id}"]
    }
  EOF
}