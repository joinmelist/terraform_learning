
provider "aws" {
  
}

module "rds" {
  source = "./module_source"

  allocated_storage      = 20
  db_name                = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "HelloNyerrae34e24"
  parameter_group_name   = "default.mysql8.0"
  vpc_security_group_ids = []
  db_subnet_group_name   = ""
  tags = {
    Environment = "dev"
  }
}