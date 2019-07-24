variable "project" {
  default = "eks-glimsil-poc"
}
variable "environment" {
  default = "dev"
}
variable "layer" {
  default = "kubernetes"
}
variable "aws-default-region" {
   default = "us-east-1"
   type = "string"
}
