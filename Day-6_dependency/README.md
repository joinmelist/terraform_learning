# Terraform Dependencies
    - A dependency in Terraform is when one resource depends on another — for example:
        - An EC2 instance depends on a Security Group and a Subnet.
        - A Route Table depends on a VPC.
        - A Load Balancer listener depends on the Load Balancer itself.


# Implicit Dependencies (Automatic) 
    - Terraform automatically infers dependencies when a resource references another.
    --> resource "aws_vpc" "main" {
            cidr_block = "10.0.0.0/16"
        }

        resource "aws_subnet" "public" {
            vpc_id     = aws_vpc.main.id  # dependency (implicit)
            cidr_block = "10.0.1.0/24"
        }
        - The reference aws_vpc.main.id automatically creates a dependency graph.

# Explicit Dependencies (Manual)

    -  Sometimes, two resources don’t have a direct attribute reference but still depend on each other.
        In that case, you can explicitly define the dependency using depends_on.
    - resource "aws_instance" "web" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
            subnet_id     = aws_subnet.public.id

            depends_on = [aws_security_group.web_sg]  # explicit dependency
        }
        - Even if you don’t reference the SG ID directly, Terraform will wait for the SG to finish before creating the instance.

# Dependencies in Modules
    - When using modules, dependencies are created via input/output variables.
    - ex :- 
            module "vpc" {
                source = "./modules/vpc"
            }

            module "ec2" {
                source   = "./modules/ec2"
                subnet_id = module.vpc.public_subnet_id  # implicit dependency
            }
        - module.vpc → module.ec2

        - If you need an explicit dependency across modules:
            module "ec2" {
                source     = "./modules/ec2"
                depends_on = [module.vpc]
            }




# Why Dependencies Matter

    Resource order -->          Ensure required resources exist first
    Safe destruction -->        Avoid deleting dependencies first
    Modular architecture -->	Modules depend on outputs from other modules
    Avoid race conditions -->	Ensures proper creation sequence
