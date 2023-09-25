variable "REGION" {
  default = "us-east-1"
}

variable "USER_PASSWORD" {
  default = "passwd123"
}

variable "USER_NAME" {
  default = "its_user"
}

variable "DB_NAME" {
  default = "its_db"
}

variable "ALL_IPS_BLOCK" {
  default = "0.0.0.0/0"
}

variable "AZS" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "DB_PORT" {
  default = 5432
}

variable "WEB_PORT" {
  default = 8000
}

variable "IMAGE_URL" {
  default = "746673457384.dkr.ecr.us-east-1.amazonaws.com/its-registry:latest"
}

variable "DJANGO_SUPERUSER_PASSWORD" {
  default = "testpass"
}

variable "DJANGO_SUPERUSER_USERNAME" {
  default = "testusr"
}

variable "DJANGO_SUPERUSER_EMAIL" {
  default = "test@gmail.com"
}
variable "CONTAINER_NAME" {
  default = "its-container"
}