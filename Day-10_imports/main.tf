provider "aws" {
  
}
resource "aws_instance" "name" {
    ami = "ami-06fa3f12191aa3337"
    instance_type = "t2.micro"
    tags = {
      Name = "testimport"
    }
}
# terraform import aws_instance.name i-0e5553b7131162bc8

resource "aws_s3_bucket" "name" {
    bucket = "demo-test-import"
  
}
#terraform import aws_s3_bucket.name demo-test-import  
# here change bucket name that already exist