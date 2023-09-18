resource "aws_instance" "its-web" {
  ami                    = var.AMI
  instance_type          = var.INSTANCE_TYPE
  count                  = 2
  key_name               = aws_key_pair.its-instance-key.key_name
  subnet_id              = aws_subnet.its-sub-pub[count.index].id
  vpc_security_group_ids = [aws_security_group.its-web-sg.id]

  tags = {
    Name = "its-web0${count.index + 1}"
  }
}

resource "aws_instance" "its-db" {
  ami                    = var.AMI
  instance_type          = var.INSTANCE_TYPE
  subnet_id              = aws_subnet.its-sub-priv-1.id
  key_name               = aws_key_pair.its-instance-key.key_name
  vpc_security_group_ids = [aws_security_group.its-db-sg.id]
  private_ip             = var.DB_PRIV_IP

  tags = {
    Name = "its-db01"
  }
}

resource "aws_instance" "its-bastion" {
  ami                    = var.AMI
  instance_type          = var.INSTANCE_TYPE
  subnet_id              = aws_subnet.its-sub-pub[0].id
  key_name               = aws_key_pair.its-bastion-key.key_name
  vpc_security_group_ids = [aws_security_group.its-bastion-sg.id]

  tags = {
    Name = "its-bastion"
  }
}