terraform {
  backend "s3" {
    bucket = "bcl-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
