#  create_before_destroy lifecycle
    - Ensures Terraform creates a new resource before destroying the old one.
    - Useful for avoiding downtime when replacing resources (e.g., servers or load balancers).
    - lifecycle {
            create_before_destroy = true
        }
    - If you change an instance’s subnet or security group (which requires recreation),
        - Terraform will:
            1.Create a new instance.
            2.Move dependencies.
            3.Destroy the old one.

# prevent_destroy lifecycle
    - lifecycle {
            prevent_destroy = true
        }
    - If you try to delete it, Terraform throws an error.
    - Use case: Production databases, S3 buckets with critical data.

# ignore_changes lifecycle
    - lifecycle {
            ignore_changes = [
                tags,
                user_data,
            ]
        }
    - Tells Terraform to ignore specific attribute changes — so Terraform won’t try to update or revert them.
    - If chnage tags name in aws console and reapply terraform no any chnage get .
    - If something (like an autoscaler or another process) changes tags or user_data dynamically, Terraform won’t fight those changes.

# replace_triggered_by lifecycle (Terraform version > 1.2+)
    - lifecycle {
            replace_triggered_by = [aws_security_group.app_sg.id]
        }
    - Forces resource replacement when another resource changes.
    - If your security group changes, Terraform automatically replaces the EC2 instance.

# Example :- 

    lifecycle {
            create_before_destroy = true     # avoid downtime
            prevent_destroy       = false    # allow deletion
            ignore_changes        = [user_data] # don't recreate on user_data drift
            replace_triggered_by  = [aws_security_group.web_sg.id] # recreate if SG changes
        }
