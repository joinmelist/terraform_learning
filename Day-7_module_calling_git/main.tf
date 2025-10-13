provider "aws" {
  
}

module "name" {
    source = "github.com/joinmelist/terraform_learning/Day-7_module_source"
    ami_id = "ami-07f07a6e1060cd2a8"
    instance_type = "t2.small"

}