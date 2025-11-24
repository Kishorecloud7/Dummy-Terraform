terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Step 1: Reference the image from the registry
resource "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

# Step 2: Pull the image using docker_image (valid for v3.x)
resource "docker_image" "nginx_image" {
  name          = docker_registry_image.nginx.name
  keep_locally  = true

  pull_triggers = [
    docker_registry_image.nginx.sha256_digest
  ]
}

# Step 3: Create container
resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.name

  ports {
    internal = 80
    external = 8080
  }
}
