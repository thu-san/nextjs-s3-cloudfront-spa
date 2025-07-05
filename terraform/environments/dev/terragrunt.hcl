# Development environment configuration
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Use the Terraform files from the parent directory
terraform {
  source = "${get_parent_terragrunt_dir()}//"
}

# Environment-specific variables
inputs = {
}
