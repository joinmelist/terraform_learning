provider "aws" {
  
}

# DB Subnet Group
resource "aws_db_subnet_group" "dev_db_subnet_group" {
  name       = "dev-db-subnet-group"
  subnet_ids = [
    "subnet-054faead5dc422b37",
    "subnet-0aaf6f492259db5c4"
  ]
  tags = {
    Name = "dev-db-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "dev_rds_sg" {
  name   = "dev-rds-sg"
  vpc_id = "vpc-0fc95f6e643e05d9c"
  tags = {
    Name = "dev-rds-sg"
  }

  # Allow MySQL traffic from application SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
   
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "dev_rds" {
    allocated_storage      = 20
    storage_type           = "gp2"
    engine                 = "mysql"
    engine_version         = "8.0"
    instance_class         = "db.t3.micro"
    db_name                = "devdb"
    username               = "admin"
    password               = "StrongPassw0rd!"
    skip_final_snapshot    = true
    publicly_accessible    = true
    backup_retention_period = 1  

    db_subnet_group_name   = aws_db_subnet_group.dev_db_subnet_group.name
    vpc_security_group_ids = [aws_security_group.dev_rds_sg.id]
    depends_on = [ aws_db_subnet_group.dev_db_subnet_group ]

    tags = {
        Name = "dev-rds"
    }
}

resource "aws_db_instance" "replica" {
    identifier              = "my-replica-db"
    replicate_source_db     = aws_db_instance.dev_rds.identifier
    instance_class          = "db.t3.micro"
    publicly_accessible     = false
    skip_final_snapshot     = true
    vpc_security_group_ids = [aws_security_group.dev_rds_sg.id]
    

    tags = {
        Name = "ReadReplica"
    }
}