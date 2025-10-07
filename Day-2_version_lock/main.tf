resource "aws_instance" "terraform" {
    ami = "mi-07f07a6e1060cd2a8"
    instance_type = "t2.micro"
  
}