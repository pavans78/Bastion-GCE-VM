terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.main.project
  region  = var.main.region
  zone    = var.main.zone
}

