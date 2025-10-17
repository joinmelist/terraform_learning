provider "aws" {
  
}
# key pair
# new generate key command :- 
#   ssh-keygen -t rsa -f <files_name> 
# in MacOs  :- /Users/<user_name>/.ssh/ 
# in windows :-  ~/.ssh/ 

resource "aws_key_pair" "demo" {
  key_name = "new_demo_test"
  public_key = file("/Users/marvel/.ssh/devops.pub")
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "cut_vpc"
    }
}

resource "aws_subnet" "name" {
    cidr_block = "10.0.0.0/26"
    availability_zone = "ap-south-1a"
    vpc_id = aws_vpc.name.id
    map_public_ip_on_launch = true

    tags = {
      Name = "public_subnet"
    }
}

resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "igw_cust"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.name.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
  
}

resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "devops-project" {
  name        = "devops-project"
  description = "Allow TLS inbound traffic"
    vpc_id = aws_vpc.name.id
  ingress = [
    for port in [22, 80, 443, 8080, 9000, 5000 ] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project"
  }
}


resource "aws_instance" "dev" {

    ami =  "ami-07f07a6e1060cd2a8"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [aws_security_group.devops-project.id]
    key_name = aws_key_pair.demo.key_name
    associate_public_ip_address = true

    tags = {
      Name = "dev"
    }

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"                          # ✅ Correct for Ubuntu AMIs
#     private_key = file("/Users/marvel/.ssh/devops")            # Path to private key
#     host        = self.public_ip
#     timeout     = "2m"
#   }

#   provisioner "file" {
#     source      = "file10"
#     destination = "/home/ubuntu/file10"
#   }

#   provisioner "remote-exec" {  #server inside 
#     inline = [
#       "touch /home/ubuntu/file200",
#       "echo 'hello from devops with aws' >> /home/ubuntu/file200"
#     ]
#   }
#    provisioner "local-exec" {  # where terraform is runnig inside the directory 
#     command = "touch file500" 
   
#  }

}


resource "null_resource" "script_update" {

    provisioner "remote-exec" {  #server inside 
        connection {
            type        = "ssh"
            user        = "ubuntu"                          # ✅ Correct for Ubuntu AMIs
            private_key = file("/Users/marvel/.ssh/devops")            # Path to private key
            host        = aws_instance.dev.public_ip
            
        }


        inline = [
            "touch /home/ubuntu/data.txt",
            "echo 'hello from devopsaws' >> /home/ubuntu/data.txt"
        ]

    }
    triggers = {
        always_run = "${timestamp()}" # Forces rerun every time
    }
}


#Solution-2 to Re-Run the Provisioner
#Use terraform taint to manually mark the resource for recreation:
# terraform taint aws_instance.server
# terraform apply