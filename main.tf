terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Get nginx from registry
resource "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

# Pull the image locally
resource "docker_image" "nginx_image" {
  name         = docker_registry_image.nginx.name
  pull_triggers = [docker_registry_image.nginx.sha256_digest]
  keep_locally = true
}

# Run the container
resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.name

  ports {
    internal = 80
    external = 8080
  }
}
