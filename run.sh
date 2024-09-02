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
environments=($(jq -r '.branches | keys | .[]' "$CONFIG_FILE"))
for i in "${!environments[@]}"; do
  echo "$((i+1)). ${environments[$i]}"
done

read -p "Select an environment by number: " env_num

# Validate the selected environment
if ! [[ "$env_num" =~ ^[0-9]+$ ]] || (( env_num < 1 || env_num > ${#environments[@]} )); then
  echo "Error: Invalid selection."
  exit 1
fi

ENVIRONMENT="${environments[$((env_num-1))]}"

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

# Prompt user to select a Terragrunt workspace
echo "Available Terragrunt workspaces:"
workspaces=($(terragrunt workspace list | sed 's/^[* ]*//'))
for i in "${!workspaces[@]}"; do
  echo "$((i+1)). ${workspaces[$i]}"
done

read -p "Select a Terragrunt workspace by number: " ws_num

# Validate the selected Terragrunt workspace
if ! [[ "$ws_num" =~ ^[0-9]+$ ]] || (( ws_num < 1 || ws_num > ${#workspaces[@]} )); then
  echo "Error: Invalid selection."
  exit 1
fi

TG_WORKSPACE="${workspaces[$((ws_num-1))]}"

# Select the Terragrunt workspace
echo "Selecting Terragrunt workspace: $TG_WORKSPACE"
terragrunt workspace select "$TG_WORKSPACE"

# Run Terragrunt plan
echo "Running Terragrunt plan..."
terragrunt plan --terragrunt-non-interactive

echo "Terragrunt plan completed successfully!"
