variable "SUBNETS" {
  default = ["subnet-02775ed3c707a99fd", "subnet-090299f7bf18d0291"]
}

variable "DEFAULT_VPC" {
  default = "vpc-0ec3239098554a0fb"
}

variable LISTENER_PORT {
  default = "8080" 
}

variable "LB_SG_ID" {
  type = string
}