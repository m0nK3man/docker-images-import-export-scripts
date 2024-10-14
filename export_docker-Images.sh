#!/bin/bash

# Directory where tarballs will be saved
EXPORT_DIR="./docker_images_export"

# Create the export directory if it doesn't exist
mkdir -p "$EXPORT_DIR"

# Get the list of all Docker images (excluding the header line)
docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}" | while read image; do
    # Split the line into image name and image ID
    image_name=$(echo "$image" | awk '{print $1}')
    image_id=$(echo "$image" | awk '{print $2}')
    
    # Create a safe filename by replacing ":" and "/" in the image name
    safe_image_name=$(echo "$image_name" | tr ':/' '-')
    
    # Define the tarball name
    tarball_name="${EXPORT_DIR}/${safe_image_name}-${image_id}.tar"
    
    echo "Saving image $image_name ($image_id) to $tarball_name..."
    
    # Save the image to a tarball
    docker save -o "$tarball_name" "$image_name"
    
    # Check if the tarball was created successfully
    if [ -f "$tarball_name" ]; then
        echo "Successfully saved $image_name ($image_id) to $tarball_name"
    else
        echo "Failed to save $image_name ($image_id)"
    fi
done

echo "All images processed."
