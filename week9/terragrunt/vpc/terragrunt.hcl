terraform {
  source  = "tfr:///terraform-aws-modules/vpc/aws?version=5.1.2"
}

include "root" {
    path = find_in_parent_folders()
}

inputs = {
  name = "its-vpc"
  azs = ["us-east-1a", "us-east-1b"]
  cidr = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  map_public_ip_on_launch = true
}