#!/bin/bash

# Define the source directory (assuming the script is in the root directory)
SOURCE_DIR="./modules"

# Get the list of environments by reading the directory names inside the components folder
COMPONENT_DIR="components"
ENVIRONMENTS=($(ls -d $COMPONENT_DIR/*/ | xargs -n 1 basename | grep -v '^common$'))

# Loop through each environment and create symlinks for modules
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="$COMPONENT_DIR/$ENV/modules"
    
    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Remove existing symlinks in the target directory
    find "$TARGET_DIR" -type l -delete
    
    # Create symlinks to the modules in the source directory
    find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -exec ln -s {} "$TARGET_DIR/" \;
    
    echo "Symlinks created successfully for $ENV environment."
done
