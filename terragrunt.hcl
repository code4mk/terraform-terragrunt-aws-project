# Define the Terraform backend configuration to use Terraform Cloud
locals {
  project_id = "61383408"
}

generate "backend" {
  path      = "auto_generated_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
    backend "http" {
      address = "https://gitlab.com/api/v4/projects/${local.project_id}/terraform/state/${get_env("THE_TF_WORKSPACE")}"
      lock_address = "https://gitlab.com/api/v4/projects/${local.project_id}/terraform/state/${get_env("THE_TF_WORKSPACE")}/lock"
      unlock_address = "https://gitlab.com/api/v4/projects/${local.project_id}/terraform/state/${get_env("THE_TF_WORKSPACE")}/lock"
      username = "${get_env("GITLAB_USERNAME")}"
      password = "${get_env("GITLAB_ACCESS_TOKEN")}"
      lock_method = "POST"
      unlock_method = "DELETE"
      retry_wait_min = 5
    }
}
EOF
}
