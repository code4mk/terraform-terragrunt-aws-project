locals {
  hostname = "hiremostafa.scalr.io"
  organization = "env-v0ogj8dl0e1b3tl9l"

  environment_name = reverse(split("/", get_terragrunt_dir()))[0]
}

terraform {
  before_hook "generate_tfvars" {
    commands = ["init", "plan", "apply", "destroy"]
    execute  = [
      "/bin/bash",
      "${get_repo_root()}/generate_tfvars_from_terragrunt.sh",
      local.environment_name,
      get_repo_root()
    ]
  }
}

generate "backend" {
  path      = "auto_generated_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "remote" {
    hostname = "${local.hostname}"
    organization = "${local.organization}"

    workspaces {
      name = "${get_env("THE_TF_WORKSPACE")}"
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