terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "nginx_image" {
  pull {
    name = docker_registry_image.nginx.name
  }
  keep_locally = true
}

resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.image_id

  ports {
    internal = 80
    external = 8080
  }
}
