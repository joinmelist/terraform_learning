#  Terraform Backend Locking


    - When multiple people (or automation systems) use the same Terraform state file, there’s a risk that two terraform apply commands might run at the same time.
        That can corrupt the state file or cause unpredictable changes.
    - Use DynamoDB for locking for all terraform version and use use_lockfile for terraform > 1.10 version
    