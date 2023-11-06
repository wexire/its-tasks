module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${var.name}-kp"
  public_key = file("ssh-keys/cci-key.pub")
}