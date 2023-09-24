resource "aws_security_group" "its-db-sg" {
  name        = "its-db-sg"
  description = "Allow access to Postgres"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description = "Postgres access"
    from_port   = var.DB_PORT
    to_port     = var.DB_PORT
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
    Name = "its-db-sg"
  }
}

resource "aws_security_group" "its-container-sg" {
  name        = "its-container-sg"
  description = "Allow access to port 8000"
  vpc_id      = aws_vpc.its-vpc.id

  ingress {
    description = "Port 8000 access"
    from_port   = var.WEB_PORT
    to_port     = var.WEB_PORT
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
    Name = "its-container-sg"
  }
}