terraform {
  backend "s3" {
    bucket = "bcl-bucket"
    key    = "day_4/terraform.tfstate"
    region = "ap-south-1"
    # use_lockfile = true  #S3 native locking
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
