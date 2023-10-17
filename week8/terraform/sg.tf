resource "aws_security_group" "its-db-sg" {
  name        = var.name
  description = "Allow access to Postgres"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Postgres access"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [var.all_ips_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ips_block]
  }
}