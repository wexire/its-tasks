terraform {
  source = "../../modules/security_groups"
}

include "root" {
    path = find_in_parent_folders()
}