resource "aws_security_group" "its-lb-sg" {
  name        = "its-lb-sg"
  description = "Allow HTTP inbound traffic for LB"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description      = "HTTP from anywhere"
    from_port        = var.LISTENER_PORT
    to_port          = var.LISTENER_PORT
    protocol         = "tcp"
    cidr_blocks      = [var.ALL_IPS_BLOCK]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-lb-sg"
  }
}

resource "aws_security_group" "its-i-sg" {
  name        = "its-i-sg"
  description = "Allow inbound traffic from LB to instances"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description      = "HTTP from LB"
    from_port        = var.LISTENER_PORT
    to_port          = var.LISTENER_PORT
    protocol         = "tcp"
    cidr_blocks      = [aws_security_group.its-lb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ALL_IPS_BLOCK]
  }

  tags = {
    Name = "its-i-sg"
  }
}