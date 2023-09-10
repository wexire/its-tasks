resource "aws_instance" "its-web" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  count = 2

  tags = {
    Name = "its-web-${count.index}"
  }
}