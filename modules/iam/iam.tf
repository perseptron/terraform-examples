resource "google_service_account" "template_sa" {
  account_id   = var.sa_id
  display_name = var.sa_name
}