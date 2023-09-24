resource "aws_db_parameter_group" "its-db-pg" {
  name   = "its-db-pg"
  family = "postgres12"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_subnet_group" "its-db-subg" {
  name       = "its-db-subg"
  subnet_ids = [aws_subnet.its-sub-pub[0].id, aws_subnet.its-sub-pub[1].id]
  tags = {
    Name = "its-db-subg"
  }
}

resource "aws_db_instance" "its-db-i" {
  allocated_storage      = 5
  db_name                = var.DB_NAME
  engine                 = "postgres"
  engine_version         = "12.16"
  instance_class         = "db.t2.micro"
  password               = var.USER_PASSWORD
  username               = var.USER_NAME
  db_subnet_group_name   = aws_db_subnet_group.its-db-subg.name
  parameter_group_name   = aws_db_parameter_group.its-db-pg.name
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.its-db-sg.id]
}