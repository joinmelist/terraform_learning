resource "aws_instance" "name" {
    instance_type = "t2.micro"
    ami = "ami-07f07a6e1060cd2a8"
    
    tags = {
      name : "terraform"
    }
  
}