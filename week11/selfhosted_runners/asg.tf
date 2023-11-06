locals {
  image_id      = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
}

module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "${var.name}-asg"

  image_id        = local.image_id
  instance_type   = local.instance_type
  key_name        = module.key_pair.key_pair_name
  security_groups = [module.security_group.security_group_id]
  user_data       = filebase64("shr_setup.sh")

  update_default_version = true

  vpc_zone_identifier   = module.vpc.public_subnets
  health_check_type     = "EC2"
  min_size              = 0
  max_size              = 0
  desired_capacity      = 0
  protect_from_scale_in = true
}