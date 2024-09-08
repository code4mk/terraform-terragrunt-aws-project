#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: Please provide both the environment name and root path as arguments."
    echo "Usage: $0 <environment_name> <root_path>"
    exit 1
fi

# Get the environment name from the first argument
ENVIRONMENT_NAME="$1"

# Get the root path from the second argument
ROOT_PATH="$2"

# Define the output file name
OUTPUT_FILE="$ROOT_PATH/projects/$ENVIRONMENT_NAME/terrant.tfvars"

# Delete the existing file if it exists
if [ -f "$OUTPUT_FILE" ]; then
    rm "$OUTPUT_FILE"
    echo "Existing $OUTPUT_FILE has been deleted."
fi

# Extract the content of the inputs block, excluding the 'inputs = {' line
awk '/inputs = {/,/^}/ {if (!/inputs = {/ && !/^}/) print}' "$ROOT_PATH/environment/$ENVIRONMENT_NAME/terragrunt.hcl" > "$OUTPUT_FILE"

echo "New $OUTPUT_FILE has been created."