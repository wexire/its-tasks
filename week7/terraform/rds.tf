resource "aws_db_parameter_group" "its-db-pg" {
  name   = var.name
  family = "postgres12"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "its-db-subg" {
  name       = var.name
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
}

resource "aws_db_instance" "its-db-i" {
  allocated_storage      = 5
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "12.16"
  instance_class         = "db.t2.micro"
  password               = var.user_password
  username               = var.user_name
  db_subnet_group_name   = aws_db_subnet_group.its-db-subg.name
  parameter_group_name   = aws_db_parameter_group.its-db-pg.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.its-db-sg.id]
}