resource "aws_security_group" "its-instance-sg" {
  name        = "its-instance-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP]
  }

  ingress {
    description     = "HTTP from the load balancer"
    from_port       = var.LISTENER_PORT
    to_port         = var.LISTENER_PORT
    protocol        = "tcp"
    security_groups = [aws_security_group.its-lb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "its-instance-sg"
  }
}

resource "aws_security_group" "its-lb-sg" {
  name        = "its-lb-sg"
  description = "Allow HTTP"

  ingress {
    description = "HTTP from anywhere"
    from_port   = var.LISTENER_PORT
    to_port     = var.LISTENER_PORT
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "its-lb-sg"
  }
}