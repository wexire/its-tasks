terraform {
  source  = "../../terraform_modules/instances"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "security_group" {
  config_path = "../security_group"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  public_subnets = dependency.vpc.outputs.public_subnets
  security_group_id = dependency.security_group.outputs.security_group_id
}