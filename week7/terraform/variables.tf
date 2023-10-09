variable "region" {
  default = "us-east-1"
}

variable "name" {
  default = "its-cluster"
}

variable "db_port" {
  default = 5432
}

variable "all_ips_block" {
  default = "0.0.0.0/0"
}

variable "db_name" {
  default = "mydb"
}

variable "user_password" {
  default = "mypassword"
}

variable "user_name" {
  default = "myname"
}