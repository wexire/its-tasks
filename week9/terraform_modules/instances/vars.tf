variable "security_group_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "control_ip" {
  default = "34.228.55.137"
}