resource "aws_key_pair" "its-bastion-key" {
  key_name   = "its-bastion-key"
  public_key = file("../ssh-keys/its-bastion-key.pub")
}

resource "aws_key_pair" "its-instance-key" {
  key_name   = "its-instance-key"
  public_key = file("../ssh-keys/its-instance-key.pub")
}