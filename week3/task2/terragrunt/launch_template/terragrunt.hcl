terraform {
  source = "../../modules/launch_template"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "security_groups" {
  config_path = "../security_groups"
}

inputs = {
  INSTANCE_SG_ID = dependency.security_groups.outputs.INSTANCE_SG_ID
}