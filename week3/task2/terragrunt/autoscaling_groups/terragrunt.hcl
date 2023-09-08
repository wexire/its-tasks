terraform {
  source = "../../modules/autoscaling_groups"
}

include "root" {
    path = find_in_parent_folders()
}

dependency "launch_template" {
  config_path = "../launch_template"
}

dependency "load_balancer" {
  config_path = "../load_balancer"
}

inputs = {
  TG_ARN = dependency.load_balancer.outputs.TG_ARN
  LT_ID = dependency.launch_template.outputs.LT_ID
}