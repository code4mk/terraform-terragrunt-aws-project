#!/bin/bash

# Function to read JSON values
function get_json_value() {
  local key="$1"
  local json_file="$2"
  echo $(jq -r "$key" "$json_file")
}

# File path to config.json
CONFIG_FILE="./config.json"

# Prompt user to pick an environment
echo "Available environments:"
for env in $(jq -r '.branches | keys | .[]' "$CONFIG_FILE"); do
  echo " - $env"
done

read -p "Select an environment: " ENVIRONMENT

# Validate the selected environment
if ! jq -e ".branches.$ENVIRONMENT" "$CONFIG_FILE" > /dev/null; then
  echo "Error: Invalid environment '$ENVIRONMENT'."
  exit 1
fi

# Extract configurations from config.json
TF_WORKSPACE=$(get_json_value ".branches.$ENVIRONMENT.TF_WORKSPACE" "$CONFIG_FILE")
TG_WORKDIR=$(get_json_value ".branches.$ENVIRONMENT.TG_WORKDIR" "$CONFIG_FILE")
TF_VERSION=$(get_json_value ".terraform_version" "$CONFIG_FILE")
TG_VERSION=$(get_json_value ".terragrunt_version" "$CONFIG_FILE")

echo "Selected environment: $ENVIRONMENT"
echo "Terraform Workspace: $TF_WORKSPACE"
echo "Terragrunt Working Directory: $TG_WORKDIR"

# Change directory to the Terragrunt working directory
cd "$TG_WORKDIR" || { echo "Error: Directory '$TG_WORKDIR' does not exist."; exit 1; }

# Initialize Terraform with Terragrunt
echo "Initializing Terragrunt..."
terragrunt init --terragrunt-non-interactive


# Validate the selected Terragrunt workspace
if ! terragrunt workspace list | grep -q "$TF_WORKSPACE"; then
  echo "Error: Invalid Terragrunt workspace '$TF_WORKSPACE'."
  exit 1
fi

# Select the Terragrunt workspace
echo "Selecting Terragrunt workspace: $TF_WORKSPACE"
terragrunt workspace select "$TF_WORKSPACE"

# Run Terragrunt plan
echo "Running Terragrunt plan..."
terragrunt plan --terragrunt-non-interactive

echo "Terragrunt plan completed successfully!"
