// we will use this value from our main module, so we have to describe it as an output
output "service_account_name" {
  value = google_service_account.template_sa.email
}