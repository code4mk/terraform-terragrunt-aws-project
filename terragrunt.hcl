# Define the Terraform backend configuration to use Terraform Cloud
locals {
  organization = "kintaro"
  workspace_tags = "terragrunt"
}

generate "backend" {
  path      = "auto_generated_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  cloud {
    organization = "${local.organization}"
    workspaces {
      name = "${local.workspace_tags}"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
EOF
}
