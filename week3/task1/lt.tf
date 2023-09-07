resource "aws_key_pair" "its-key" {
  key_name   = "its-key"
  public_key = file("its-key.pub")
}

resource "aws_launch_template" "its-lt" {
  name                   = "its-lt"
  image_id               = var.AMI
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.its-key.key_name
  vpc_security_group_ids = [aws_security_group.its-instance-sg.id]
  user_data              = filebase64("web_setup.sh")
  update_default_version = "true"

  tags = {
    Name = "${var.env}-lt"
  }
}