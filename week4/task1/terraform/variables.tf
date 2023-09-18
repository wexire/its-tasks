variable "AMI" {
  default = "ami-01c647eace872fc02"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "REGION" {
  default = "us-east-1"
}

variable "ALL_IPS_BLOCK" {
  default = "0.0.0.0/0"
}

variable "LISTENER_PORT" {
  default = 80
}

variable "AZS" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "CONTROL_IP" {
  default = "54.145.83.7"
}

variable "USER" {
  default = "ec2-user"
}

variable "DB_PRIV_IP" {
  default = "10.0.3.247"
}