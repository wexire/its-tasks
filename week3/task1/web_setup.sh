#!/bin/bash

# Update the system and install Docker
sudo yum update -y
sudo yum install -y docker

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Variables
IMAGE_NAME="nginx"             # NGINX Docker image
IMAGE_TAG="latest"             # Latest version
CONTAINER_NAME="nginx-container"  # Container name
PORT_MAPPING="8080:80"           # Port mapping (host:container)

# Pull the NGINX Docker image
sudo docker pull "$IMAGE_NAME:$IMAGE_TAG"

# Run the NGINX Docker container
sudo docker run -d --name "$CONTAINER_NAME" -p "$PORT_MAPPING" "$IMAGE_NAME:$IMAGE_TAG"