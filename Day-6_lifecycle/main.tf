provider "aws" {
  
}

resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    tags = {
      Name = "ec2"
    }
    lifecycle {
      prevent_destroy = false
      create_before_destroy = true
      ignore_changes = [ tags ]
      
    }
  
}