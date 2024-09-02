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

# Terraform Terragrunt GitHub Actions Workflow

This repository contains a GitHub Actions workflow to automate Terraform and Terragrunt operations for different environments. The workflow requires certain GitHub secrets to be configured.

## Setting Up GitHub Secrets

To use this workflow, you'll need to configure the following secrets in your GitHub repository:

### 1. Terraform and Terragrunt Versions

- **`THE_TG_VERSION`**: The version of Terragrunt to use (e.g., `0.57.0`).
- **`THE_TF_VERSION`**: The version of Terraform to use (e.g., `1.8.0`).

### 2. Terraform Cloud API Token

- **`TF_API_TOKEN`**: A Terraform Cloud API token used for authentication.

### 3. Environment-Specific Secrets

These secrets should be named according to the branch they correspond to (`main`, `stage`, or `dev`):

- **`MAIN_TF_WORKSPACE`**: The Terraform workspace for the `main` branch.
- **`MAIN_TG_WORKDIR`**: The Terragrunt working directory for the `main` branch.

- **`STAGE_TF_WORKSPACE`**: The Terraform workspace for the `stage` branch.
- **`STAGE_TG_WORKDIR`**: The Terragrunt working directory for the `stage` branch.

- **`DEV_TF_WORKSPACE`**: The Terraform workspace for the `dev` branch.
- **`DEV_TG_WORKDIR`**: The Terragrunt working directory for the `dev` branch.

### How to Set Up Secrets in GitHub

1. Navigate to your repository on GitHub.
2. Click on the **Settings** tab.
3. In the left sidebar, click on **Secrets and variables** > **Actions**.
4. Click the **New repository secret** button.
5. Add each secret by specifying its name and value, then click **Add secret**.

### Example Secret Configuration

For a repository that uses Terraform and Terragrunt, you would configure secrets as follows:

- **Secret Name**: `THE_TG_VERSION`
  - **Value**: `0.57.0`

- **Secret Name**: `THE_TF_VERSION`
  - **Value**: `1.8.0`

- **Secret Name**: `TF_API_TOKEN`
  - **Value**: `<your-terraform-cloud-api-token>`

- **Secret Name**: `MAIN_TF_WORKSPACE`
  - **Value**: `prod-project`

- **Secret Name**: `MAIN_TG_WORKDIR`
  - **Value**: `environment/prod`

- **Secret Name**: `STAGE_TF_WORKSPACE`
  - **Value**: `stage-project`

- **Secret Name**: `STAGE_TG_WORKDIR`
  - **Value**: `environment/stage`

- **Secret Name**: `DEV_TF_WORKSPACE`
  - **Value**: `dev-project`

- **Secret Name**: `DEV_TG_WORKDIR`
  - **Value**: `environment/dev`

## Usage

Once the secrets are configured, the workflow will automatically pick them up and run Terraform and Terragrunt operations when changes are pushed to the `main`, `stage`, or `dev` branches.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
