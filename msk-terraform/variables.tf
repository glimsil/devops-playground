variable "project" {
  default = "msk-poc"
}

variable "environment" {
  default = "dev"
}

variable "layer" {
  default = "kubernetes"
}

variable "aws-default-region" {
   default = "us-east-2"
   type = "string"
}
