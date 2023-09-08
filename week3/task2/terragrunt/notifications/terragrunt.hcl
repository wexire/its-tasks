terraform {
  source = "../../modules/notifications"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "autoscaling_groups" {
  config_path = "../autoscaling_groups"
}

inputs = {
  ASG_NAME = dependency.autoscaling_groups.outputs.ASG_NAME
}