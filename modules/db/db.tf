resource "google_sql_database_instance" "instance" {
  name             = local.server_name
  database_version = var.db_version
  deletion_protection = false

  settings {
    tier = var.vm_tier
  }
}

resource "google_sql_database" "database" {
  name     = local.database_name
  instance = google_sql_database_instance.instance.name

}