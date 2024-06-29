#!/bin/bash

# Define the source directory
SOURCE_DIR="./modules"

# Get the list of environments by reading the directory names inside the component folder
COMPONENT_DIR="components"
ENVIRONMENTS=($(ls -d $COMPONENT_DIR/*/ | xargs -n 1 basename | grep -v '^common$'))

# Loop through each environment and sync the modules
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="components/$ENV/modules1"
    
    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Sync modules to the environment
    rsync -av --delete "$SOURCE_DIR/" "$TARGET_DIR/"
    
    echo "Modules synced successfully to $ENV environment."
done
