provider "aws" {
  
}
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  subnet_cidr  = "10.0.1.0/24"
  az           = "ap-south-1a"
}


module "ec2" {
  source = "./modules/ec2"
  ami_id = "ami-07f07a6e1060cd2a8"
  instance_type = var.instance_type
  subnet_id = module.vpc.subnet_id
  
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "hello-chaild-module-s3"
}

module "rds" {
  source         = "./modules/RDS"
  subnet_id      = module.vpc.subnet_id
  instance_class = "db.t3.micro"
  db_name        = "mydbadmin"
  db_user        = "admin"
  db_password    = "adminAdmin12345"
}