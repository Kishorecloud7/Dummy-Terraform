terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Step 1: Read the latest image from Docker Hub
resource "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

# Step 2: Pull the image locally
resource "docker_image" "nginx_image" {
  name         = docker_registry_image.nginx.name
  pull_triggers = [docker_registry_image.nginx.sha256_digest]
  keep_locally = true
}

# Step 3: Create the container
resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.image_id

  ports {
    internal = 80
    external = 8080
  }
}
