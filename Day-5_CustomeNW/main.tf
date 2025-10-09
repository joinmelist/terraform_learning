provider "aws" {
  
}
# create vpc
resource "aws_vpc" "custome" {
    cidr_block = var.vpc_cidr_block
    tags = {
      name = "private_1"
    }
}

# create subnet public
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.custome.id
    availability_zone = "ap-south-1b"
    cidr_block = var.subnet_cidr_block
    tags = {
      name = "subnet_1_public"
    }
}

# create subnet private
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.custome.id
    availability_zone = "ap-south-1b"
    cidr_block =var.subnet2_cidr_block
    tags = {
      name = "subnet_1_private"
    }
}

# create IGW
resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.custome.id
  tags = {
    name = "igw_1"
  }
}

# create RouteTable Public
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.custome.id
    route {
        cidr_block = var.router_cidr_block
        gateway_id = aws_internet_gateway.public.id
    }
    tags = {
        Name = "public_table"
    }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# create security group

resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.custome.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 8000
    to_port     = 8010
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}

# create EC2 - public

resource "aws_instance" "public_ec2" {
    ami = var.ami_name
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    instance_type = var.instance_type
}


# create elastic_ip
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

# create NAT
resource "aws_nat_gateway" "name" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_eip.id
  tags = {
    name = "nat_1"
  }
  depends_on = [aws_internet_gateway.public] # ensures IGW is created first
}

# create private route table
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.custome.id
    route {
        cidr_block = var.router_cidr_block
        gateway_id = aws_nat_gateway.name.id
    }
    tags = {
        Name = "private_table"
    }
}
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# create EC2 - private

resource "aws_instance" "private_ec2" {
    ami = var.ami_name
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    instance_type = var.instance_type
}
