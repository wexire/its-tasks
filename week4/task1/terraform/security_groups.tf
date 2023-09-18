resource "aws_security_group" "its-lb-sg" {
  name        = "its-lb-sg"
  description = "Allow HTTP inbound traffic for LB"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = var.LISTENER_PORT
    to_port     = var.LISTENER_PORT
    protocol    = "tcp"
    cidr_blocks = [var.ALL_IPS_BLOCK]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-lb-sg"
  }
}

resource "aws_security_group" "its-web-sg" {
  name        = "its-web-sg"
  description = "Allow inbound traffic from LB and Bastion to instances"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description     = "HTTP from LB"
    from_port       = var.LISTENER_PORT
    to_port         = var.LISTENER_PORT
    protocol        = "tcp"
    security_groups = [aws_security_group.its-lb-sg.id]
  }

  ingress {
    description = "SSH from control machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.CONTROL_IP}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-web-sg"
  }
}

resource "aws_security_group" "its-bastion-sg" {
  name        = "its-bastion-sg"
  description = "Allow SSH from my IP"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description = "SSH from control machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.CONTROL_IP}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-bastion-sg"
  }
}

resource "aws_security_group" "its-db-sg" {
  name        = "its-db-sg"
  description = "Allow SSH from Bastion to instances"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.its-bastion-sg.id]
  }

  ingress {
    description     = "DB for Web"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.its-web-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-db-sg"
  }
}