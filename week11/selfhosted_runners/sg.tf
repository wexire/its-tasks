module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.name}-sg"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow SSH from my IP"
      cidr_blocks = "176.37.225.82/32"
    },
  ]

  egress_rules = ["all-all"]
}