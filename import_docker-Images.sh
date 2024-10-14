#!/bin/bash

# Directory where tarballs are stored
EXPORT_DIR="./docker_images_export"

# Check if the export directory exists
if [ ! -d "$EXPORT_DIR" ]; then
    echo "Directory $EXPORT_DIR does not exist. Please check the path."
    exit 1
fi

# Find all .tar files in the export directory and load them into Docker
for tarball in "$EXPORT_DIR"/*.tar; do
    if [ -f "$tarball" ]; then
        echo "Loading image from $tarball..."
        
        # Load the image
        docker load -i "$tarball"
        
        # Check if the load was successful
        if [ $? -eq 0 ]; then
            echo "Successfully loaded image from $tarball"
        else
            echo "Failed to load image from $tarball"
        fi
    else
        echo "No tarball files found in $EXPORT_DIR."
    fi
done

echo "All images processed."
