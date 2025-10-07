
# AWS cli Installation

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

aws --version
    - aws configure
# Install Terraform
https://developer.hashicorp.com/terraform/install

teraaform --version

terraform init :- Initialise the plugins from terraform registry to working directory
terraform plan :- It gives blue print what you are going to create
terraform apply :- Cretae aresources as per the code


Terraform Configuration files :-
    - provider.tf :- where we can add providers details (gcp,aws,azure)
    - main.tf :-  where we can resource details (ec2,s3,rds)
    - variables.tf :- variables the values to insert into main.tx
    - output.tx :- it will print the required values after cretae resources