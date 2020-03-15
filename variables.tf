variable "application" {
  default = "orbs-ganache"
}

variable "provisionersrc" {
  default = "orbs-network/terraform-ethereum-ganache"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR address range"
  default     = "172.31.0.0/16"
}

variable "instance_type" {
  default = "t2.small"
}

variable "ssh_keypath" {
  default = "~/.ssh/id_rsa.pub"
}

variable "region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}