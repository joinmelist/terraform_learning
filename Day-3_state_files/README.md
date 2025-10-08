#  Terraform state file 
    - It is contain all details of create,chnages and destroy of resorces in provides .
    - It must be stae file name is "terraform.tfstate" if any other name is consider is None.
    - In 1st time no state file then terrafoem apply is direct to call provider and 2nd time 
        apply command check 1st Refreshing state and get states .
    - Tracks resources Terraform manages.
    - By default in local and when write code for production is location in remote (like S3, Azure, GCS, Terraform Cloud)
    - view state :- terraform show
    - List Resources :- terraform state list OR terraform state show aws_instance.myserver