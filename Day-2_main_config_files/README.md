
# dynemic variable use for resorces
    - In variables.tf files add dynemic variable use in main files 
    - and one other file use in terraforn.tfvars for all variable in override in variables.tx file using this
    - run cli :- 
        terraform plan  -var-file="dev.tfvars"
        terraform apply -auto-approve -var-file="dev.tfvars" 
            // if dev.tfvars not files name and name is terraform.tfvars no mantion to -var-files flag
        terraform apply -auto-approve  // if terraform.tfvars 


# Opuput File 
    - in this file add to output of resource data like public_ip,private_ip,arn