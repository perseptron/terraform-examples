// because we are not allowed to use variables for defining variables,
// we have to take advantage of locals construcion
locals {
  server_name = "${var.region}-db"
  database_name= "${var.project}-${var.db_version}"
}