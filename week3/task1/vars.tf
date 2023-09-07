variable "REGION" {
  default = "us-east-1"
}

variable "AMI" {
  default = "ami-051f7e7f6c2f40dc1"
}

variable "MY_IP" {
  default = "176.37.225.82/32"
}

variable "AZ1" {
  default = "us-east-1a"
}

variable "AZ2" {
  default = "us-east-1b"
}

variable "SUBNET_A" {
  default = "subnet-02775ed3c707a99fd"
}

variable "SUBNET_B" {
  default = "subnet-090299f7bf18d0291"
}

variable "LISTENER_PORT" {
  default = "8080"
}

variable "DEFAULT_VPC" {
  default = "vpc-0ec3239098554a0fb"
}

variable "env" {
  default = "its"
}