remote_state {
    backend = "local"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        path = "${path_relative_to_include()}/terraform.tfstate"
    }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = var.aws_region
}

variable "aws_region" {}

EOF
}

terraform {
  extra_arguments "common_vars" {
    commands  = get_terraform_commands_that_need_vars()
    
    required_var_files = [find_in_parent_folders("common.tfvars")]
  }
}