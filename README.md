# ecr-repo-cross-account
Create a Terraform module that creates a cross-account ECR repository. Cross-account access should be limited to reading from the repository. It must have a lifecycle policy attached to it to allow for automatic cleanup of old images.
