locals {
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name}-vpc"
  cidr = local.vpc_cidr

  azs            = local.azs
  public_subnets = local.public_subnets

  map_public_ip_on_launch = true
}