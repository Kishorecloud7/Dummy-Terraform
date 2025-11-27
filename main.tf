terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx_image" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = "my-nginx"
  image = docker_image.nginx_image.latest

  ports {
    internal = 80
    external = 8080
  }
}
