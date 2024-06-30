# Define the Terraform backend configuration to use Terraform Cloud
locals {
  organization = "kintaro"
  workspace_tags = "kintaro_devops"
}

terraform {
  before_hook "workspace" {
    commands = ["plan", "state", "apply", "destroy", "init"]
    execute = ["terraform", "workspace", "select", "terragrunt"]
  }
}

generate "backend" {
  path      = "auto_generated_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  cloud {
    organization = "${local.organization}"
    workspaces {
      tags = ["${local.workspace_tags}"]
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
