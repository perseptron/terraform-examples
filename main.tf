# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.23.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "www"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
  upload {
    file   = "/usr/share/nginx/html/index.html"
    source = "index.html"
  }
}

resource "docker_image" "mariadb" {
  name         = "mariadb:latest"
  keep_locally = false
}

variable "db_root_password" {
  description = "mariadb password"
  type        = string
  default     = "123123"
  sensitive   = true
}

resource "docker_container" "mariadb" {
  name  = "db"
  image = docker_image.mariadb.image_id
  env = [
    "MARIADB_ROOT_PASSWORD=${var.db_root_password}"
  ]
  ports {
    internal = 3306
    external = 3306
  }

}
