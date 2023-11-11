terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      required_version = ">= 4.80.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
