provider "aws" {
  
}

module "name" {
    source = "../Day-7_module_source"
    ami_id = "ami-07f07a6e1060cd2a8"
    instance_type = "t2.nano"
    tags_name = "demo_module"
}