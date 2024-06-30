#!/bin/bash

# Define the source directory (assuming the script is in the root directory)
SOURCE_DIR="modules"

# Get the list of environments by reading the directory names inside the terraform folder
COMPONENT_DIR="terraform"
ENVIRONMENTS=($(ls -d $COMPONENT_DIR/*/ | xargs -n 1 basename | grep -v '^common$'))

# Loop through each environment and create symlinks for modules
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="$COMPONENT_DIR/$ENV/modules"
    
    # Ensure the target directory exists
    mkdir -p "$TARGET_DIR"
    
    # Remove existing symlinks in the target directory
    find "$TARGET_DIR" -type l -delete
    
    # Create symlinks to the modules in the source directory
    for MODULE in "$SOURCE_DIR"/*; do
        MODULE_NAME=$(basename "$MODULE")
        ln -s "../../../$MODULE" "$TARGET_DIR/$MODULE_NAME"
    done
    
    echo "Symlinks created successfully for $ENV environment."
done

# Set read-only permissions on the target files through the symlinks
for ENV in "${ENVIRONMENTS[@]}"; do
    TARGET_DIR="$COMPONENT_DIR/$ENV/modules"
    
    # Iterate over each symlink and set the target file permissions
    for SYMLINK in "$TARGET_DIR"/*; do
        TARGET_FILE=$(readlink -f "$SYMLINK")
        chmod 111 "$TARGET_FILE"
    done
done

echo "Permissions set to read-only for all target files."
