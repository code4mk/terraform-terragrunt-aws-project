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
│   │   ├── modules (symlink with root modules)
│   │   ├── common-*.tf (symlink with common)
│   │   ├── main.tf
│   │   └── variables.tf
│   └── prod
│       ├── modules (symlink with root modules)
│       ├── common-*.tf (symlink with common)
│       ├── main.tf
│       └── variables.tf
└── environment
    ├── stage
    │   └── terragrunt.hcl
    └── prod
        └── terragrunt.hcl
```