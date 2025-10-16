# Terraform import

    - terraform import allows you to bring existing infrastructure (created manually or outside Terraform) under Terraform management — without recreating it.

    ==> How it works :- 
        - You already have a resource in AWS / Azure / GCP / etc.
        - You define a matching resource block in Terraform (main.tf).
        - You run terraform import to link the existing resource to that block.
        - Terraform records it in the state file (terraform.tfstate).
        - Then you run terraform plan — Terraform sees it as “already created.”