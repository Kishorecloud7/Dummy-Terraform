terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Pull latest nginx image
resource "docker_image" "nginx_image" {
  name = "nginx:latest"
  keep_locally = true
}

# Create Container
resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.image_id

  ports {
    internal = 80
    external = 8080
  }
}
