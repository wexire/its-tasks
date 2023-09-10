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

variable "AZ1" {
  default = "us-east-1a"
}

variable "AZ2" {
  default = "us-east-1b"
}