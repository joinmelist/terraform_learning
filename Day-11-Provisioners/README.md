#  Terraform Provisioner

    - A provisioner in Terraform is a way to execute scripts or commands on a resource (usually a server) after it’s created — for setup, configuration, or bootstrapping.
    - Think of it like post-creation automation, similar to running shell scripts or Ansible tasks after provisioning.



    | Provisioner                               | Purpose                                                                 |
    | ----------------------------------------- | ----------------------------------------------------------------------- |
    | `local-exec`                              | Run a command **on your local machine** (where Terraform runs)          |
    | `remote-exec`                             | Run a command **on the remote resource** (like an EC2 instance via SSH) |
    | `file`                                    | Upload a file or directory to a remote machine                          |
    | `chef`, `puppet`, `salt-masterless`, etc. | (Legacy) Integrations with config management tools                      |
    | `null_resource`                           | Dummy resource used to run provisioners without creating real infra     |



    🔧 Common use cases

    - Installing software packages after EC2 creation
    - Bootstrapping configuration files
    - Registering instances to monitoring systems
    - Triggering local scripts (CI/CD, notifications)
    - Copying files to instances before configuration


    Example 1 — local-exec Provisioner

        resource "aws_instance" "web" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"

            provisioner "local-exec" {
                command = "echo Instance ${self.id} created at $(date) >> created.log"
            }
        }

    Example 2 — remote-exec Provisioner

        resource "aws_instance" "web" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
            key_name      = "mykey"

            provisioner "remote-exec" {
                inline = [
                "sudo apt-get update -y",
                "sudo apt-get install -y nginx",
                "sudo systemctl start nginx"
                ]
            }

            connection {
                type        = "ssh"
                user        = "ubuntu"
                private_key = file("~/.ssh/mykey.pem")
                host        = self.public_ip
            }
        }


    Example 3 — file Provisioner

        resource "aws_instance" "app" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t3.micro"
            key_name      = "mykey"

            provisioner "file" {
                source      = "setup.sh"    # local system path
                destination = "/tmp/setup.sh". # remote system path
            }

            connection {
                type        = "ssh"
                user        = "ubuntu"
                private_key = file("~/.ssh/mykey.pem")
                host        = self.public_ip
            }
        }


    Example 4 — Combine file + remote-exec

        resource "aws_instance" "web" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t3.micro"
            key_name      = "mykey"

            provisioner "file" {
                source      = "setup.sh"    # local system path
                destination = "/tmp/setup.sh". # remote system path
            }

            provisioner "remote-exec" {
                inline = [
                "chmod +x /tmp/setup.sh",
                "sudo /tmp/setup.sh"
                ]
            }

            connection {
                type        = "ssh"
                user        = "ubuntu"
                private_key = file("~/.ssh/mykey.pem")
                host        = self.public_ip
            }
        }


