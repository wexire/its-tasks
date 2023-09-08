terraform {
  source = "../../modules/load_balancer"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "security_groups" {
  config_path = "../security_groups"
}

inputs = {
  LB_SG_ID = dependency.security_groups.outputs.LB_SG_ID
}