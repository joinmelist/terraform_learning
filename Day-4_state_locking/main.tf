provider "aws" {
  
}

resource "aws_instance" "ec2_server" {
  ami = var.ami_name
  instance_type = "t2.micro"
  tags = {
    "name"  = "dev_ec2"
  }
}


variable "ami_name" {
  default =  "ami-07f07a6e1060cd2a8"
  description = "os ami"
  type = string
}

output "public_ip" {
  value = aws_instance.ec2_server.public_ip
}
