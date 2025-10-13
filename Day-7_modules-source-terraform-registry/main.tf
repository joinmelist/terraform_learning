provider "aws" {
  
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  key_name      = "private"
  monitoring    = true
  subnet_id     = "subnet-0aaf6f492259db5c4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  
}