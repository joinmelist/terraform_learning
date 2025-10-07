resource "aws_instance" "terraform" {    # resource_name :- terraform 
  ami           = var.ami_name
  instance_type = var.instance_type_name
  tags          = { name : "terraform_1" }  # instance_name :- terraform_1

}

resource "aws_instance" "terraform_2" {    # resource_name :- terraform_2
  ami           = var.ami_name
  instance_type = var.instance_type_name
  tags          = { name : "terraform_2" }  # instance_name :- terraform_2

}


# terraform apply -auto-approve -var-file="dev.tfvars"