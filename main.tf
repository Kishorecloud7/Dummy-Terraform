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

# Step 2: Pull the image locally (CORRECT v3 syntax)
resource "docker_image" "nginx_image" {
  pull {
    name = docker_registry_image.nginx.name
  }

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
