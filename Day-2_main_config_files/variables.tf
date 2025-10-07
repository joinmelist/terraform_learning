variable "ami_name" {
    description = "ami name for instance"
    type = string
    default = "" 
}
variable "instance_type_name" {
    description = "instance type"
    type = string
    default = "t2.micro" 
}