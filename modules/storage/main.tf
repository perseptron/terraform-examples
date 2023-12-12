resource "google_storage_bucket" "backend_bucket" {
  name          = var.backend_bucket_name
  location      = var.backend_bucket_location
  force_destroy = true

  public_access_prevention = "enforced"

  versioning {
    enabled = true
  }
}