variable "ami_name" {
    type = string
    default = "ami-07f07a6e1060cd2a8"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "router_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}
variable "subnet_cidr_block" {
  type = string
  default = "10.0.0.0/26"
}
variable "subnet2_cidr_block" {
  type = string
  default = "10.0.1.0/26"
}
variable "subnet3_cidr_block" {
  type = string
  default = "10.1.0.0/26"
}