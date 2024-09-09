#!/bin/bash

# Function to read JSON values
function get_json_value() {
  local key="$1"
  local json_file="$2"
  jq -r "$key" "$json_file"
}

# File path to config.json
CONFIG_FILE="./config.json"

echo "=== Terragrunt Management Script ==="
echo "This script helps manage Terragrunt operations across different environments."

# Prompt user to pick an environment
echo -e "\n=== Environment Selection ==="
echo "Available environments:"
for env in $(jq -r '.branches | keys | .[]' "$CONFIG_FILE"); do
  echo " - $env"
done

read -p "Select an environment: " ENVIRONMENT

# Validate the selected environment
if ! jq -e ".branches.\"$ENVIRONMENT\"" "$CONFIG_FILE" > /dev/null; then
  echo "Error: Invalid environment '$ENVIRONMENT'. Please run the script again and choose a valid environment."
  exit 1
fi

# Extract configurations from config.json
TF_WORKSPACE=$(get_json_value ".branches.\"$ENVIRONMENT\".TF_WORKSPACE" "$CONFIG_FILE")
TG_WORKDIR=$(get_json_value ".branches.\"$ENVIRONMENT\".TG_WORKDIR" "$CONFIG_FILE")
TF_VERSION=$(get_json_value ".terraform_version" "$CONFIG_FILE")
TG_VERSION=$(get_json_value ".terragrunt_version" "$CONFIG_FILE")

echo -e "\n=== Configuration Details ==="
echo "Selected environment: $ENVIRONMENT"
echo "Terraform Workspace: $TF_WORKSPACE"
echo "Terragrunt Working Directory: $TG_WORKDIR"
echo "Terraform Version: $TF_VERSION"
echo "Terragrunt Version: $TG_VERSION"

# Prompt user for action
echo -e "\n=== Action Selection ==="
read -p "Select action (plan/apply/destroy): " ACTION

case $ACTION in
  plan|apply)
    echo -e "\n=== Symlinking Modules ==="
    echo "Creating symbolic links for modules..."
    ./symlink-modules.sh
    echo "Symlinking completed."
    ;;
  destroy)
    echo -e "\n=== Skipping Symlinking ==="
    echo "Symlinking is not required for destroy action."
    ;;
  *)
    echo "Error: Invalid action '$ACTION'. Please run the script again and choose plan, apply, or destroy."
    exit 1
    ;;
esac

# Change directory to the Terragrunt working directory
echo -e "\n=== Changing to Terragrunt Working Directory ==="
echo "Navigating to: $TG_WORKDIR"
cd "$TG_WORKDIR" || { echo "Error: Directory '$TG_WORKDIR' does not exist. Please check your configuration."; exit 1; }

export THE_TF_WORKSPACE="$TF_WORKSPACE"

# Initialize Terraform with Terragrunt
echo -e "\n=== Initializing Terragrunt ==="
echo "Running: terragrunt init --terragrunt-non-interactive"
terragrunt init --terragrunt-non-interactive


# Run the selected Terragrunt action
echo -e "\n=== Executing Terragrunt $ACTION ==="
echo "Running: terragrunt $ACTION --terragrunt-non-interactive"
case $ACTION in
  plan)
    terragrunt plan --terragrunt-non-interactive
    ;;
  apply)
    terragrunt apply --terragrunt-non-interactive
    ;;
  destroy)
    echo "Warning: You are about to destroy resources. This action is irreversible."
    read -p "Are you sure you want to proceed with destroy? (yes/no): " CONFIRM
    if [ "$CONFIRM" = "yes" ]; then
      terragrunt destroy --terragrunt-non-interactive
    else
      echo "Destroy action cancelled."
      exit 0
    fi
    ;;
esac

echo -e "\n=== Operation Complete ==="
echo "Terragrunt $ACTION completed successfully!"
echo "Thank you for using the Terragrunt Management Script."
