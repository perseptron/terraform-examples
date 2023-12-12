variable "project" {
  description = "Project name"
  type        = string
  default     = "project1-407717"
}

variable "region" {
  description = "default region to deploy infrastructure"
  type        = string
  default     = "europe-central2"
}

variable "db_version" {
  description = "Database server version"
  type        = string
  default     = "MYSQL_5_7"
}

variable "vm_tier" {
  description = "Database server machine tier"
  type        = string
  default     = "db-f1-micro"
}