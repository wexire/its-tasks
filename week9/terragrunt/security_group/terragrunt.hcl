terraform {
  source  = "tfr:///terraform-aws-modules/security-group/aws?version=5.1.0"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name        = "nodes-sg"
  description = "Allow SSH to the instances"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["all-tcp"]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}