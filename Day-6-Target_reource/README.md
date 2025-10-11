#  Terraform Target-reource
    - script run :-
        - terraform init
        - terraform plan -target=aws_s3_bucket.name
        - terraform apply -auto-approve  -target=aws_s3_bucket.name
        - terraform destroy -auto-approve  -target=aws_s3_bucket.name

    - Targeting lets you tell Terraform to apply, plan, or destroy only specific resources — instead of the entire configuration.
    
    - Basic Syntax :- 
        terraform apply -target=RESOURCE_TYPE.NAME
        terraform apply -target=aws_instance.web
    
    - Multiple Targets :- 
        terraform apply -target=aws_vpc.main -target=aws_subnet.public

    - Builds a partial dependency graph for the targeted resource(s)
    - Only evaluates and applies those resources and their dependencies
    - Skips unrelated resources in the configuration
