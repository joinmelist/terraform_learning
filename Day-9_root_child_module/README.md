#  Terraform root & child modules

    - chaild module where we can declare the multiple resources.
    - root module from where we can control that chaild module.

            terraform/
            ├─ modules/
            │  ├─ vpc/
            │  │  ├─ main.tf
            │  │  ├─ variables.tf
            │  │  └─ outputs.tf
            │  └─ ec2/
            │     ├─ main.tf
            │     ├─ variables.tf
            │     └─ outputs.tf
            │  ├─ s3/
            │  │  ├─ main.tf
            │  │  ├─ variables.tf
            │  │  └─ outputs.tf
            │  └─ RDS/
            │     ├─ main.tf
            │     ├─ variables.tf
            └─ README.md
            ├─ main.tf
            ├─ variables.tf
            ├─ terraform.tfvars
            │ 

