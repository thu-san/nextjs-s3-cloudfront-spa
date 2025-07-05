# Root terragrunt configuration
# This is a Terragrunt configuration file, not a Terraform file
# Terragrunt-specific blocks like 'generate' and 'include' are expected here
locals {
  project_name = "nextjs-s3-cloudfront-spa" # TODO use this for project name

  # Parse the environment from the path
  environment = basename(path_relative_to_include())

  # Common variables for all environments
  common_vars = {
    common_tags = {
      Project   = local.project_name
      ManagedBy = "terragrunt"
    }
  }

  # Define SSM parameter name
  ssm_parameter_name = "/terraform/${local.project_name}/${local.environment}/backend-config"
  
  # Fetch backend configuration from SSM Parameter Store
  # Using a single encrypted parameter with JSON format for efficiency
  backend_config_json = run_cmd("--terragrunt-quiet", "aws", "ssm", "get-parameter", 
    "--name", local.ssm_parameter_name, 
    "--with-decryption", 
    "--query", "Parameter.Value", 
    "--output", "text")
  
  # Parse the JSON configuration
  backend_config_map = jsondecode(local.backend_config_json)
  
  # Extract individual values from the JSON
  backend_bucket         = local.backend_config_map.bucket
  backend_region         = local.backend_config_map.region
  backend_dynamodb_table = local.backend_config_map.dynamodb_table
  backend_role_arn       = local.backend_config_map.role_arn

  # Get current AWS account ID
  account_id = get_aws_account_id()

  # Environment-specific backend configuration
  backend_config = {
    bucket         = local.backend_bucket
    key            = "${local.account_id}-open-source-software/${local.environment}/${local.project_name}.tfstate"
    region         = local.backend_region
    encrypt        = true
    dynamodb_table = local.backend_dynamodb_table
  }
}

# Generate backend configuration
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.backend_config.bucket}"
    key            = "${local.backend_config.key}"
    region         = "${local.backend_config.region}"
    encrypt        = ${local.backend_config.encrypt}
    dynamodb_table = "${local.backend_config.dynamodb_table}"${local.backend_role_arn != "" ? "\n    assume_role = {\n      role_arn = \"${local.backend_role_arn}\"\n    }" : ""}
  }
}
EOF
}

# Configure Terraform/OpenTofu version constraints
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var", "environment=${local.environment}",
    ]
  }
}

# Expose common variables to child configurations
inputs = merge(
  local.common_vars,
  {
    environment = local.environment
  }
)