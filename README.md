# terraform-terragrunt-aws-project

# File structure

```bash
terrafrom-terragrunt-aws-project
├── terragrunt.hcl
├── modules
│   ├── subnet
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── projects
│   ├── common
│   │   └── common-resources.tf
│   ├── stage
│   │   ├── modules (symlink with root modules via script)
│   │   ├── common-*.tf (symlink with common via script)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   └── prod
│       ├── modules (symlink with root modules via script)
│       ├── common-*.tf (symlink with common)
│       ├── main.tf
│       ├── variables.tf
│       └── output.tf
└── environment
    ├── stage
    │   └── terragrunt.hcl
    └── prod
        └── terragrunt.hcl
```

---

# Run locally

## update config file
The `config.json` file contains essential configurations for Terraform and Terragrunt. You should update this file to match your environment and branch-specific settings.

## cli command

```bash
./run.sh
```

# Run GitHub Action (Terragrunt Plan and Apply)

## Setting Up GitHub Secrets

To ensure that the GitHub Action workflow runs correctly, you need to set up the following GitHub secret:

- **`TF_API_TOKEN`**: This is a Terraform Cloud API token used for authentication.

## Update Config File

The `config.json` file contains essential configurations for Terraform and Terragrunt. You should update this file to match your environment and branch-specific settings.

### Config File Structure

Here is the format for `config.json`:

```json
{
  "terraform_version": "1.8.0",
  "terragrunt_version": "0.57.0",
  "branches": {
    "main": {
      "TF_WORKSPACE": "prod-project",
      "TG_WORKDIR": "environment/stage"
    },
    "stage": {
      "TF_WORKSPACE": "stage-project",
      "TG_WORKDIR": "environment/stage"
    },
    "dev": {
      "TF_WORKSPACE": "dev-project",
      "TG_WORKDIR": "environment/dev"
    },
    "default": {
      "TF_WORKSPACE": "default",
      "TG_WORKDIR": "environment/default"
    }
  }
}



