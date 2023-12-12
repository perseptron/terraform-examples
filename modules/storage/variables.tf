variable "backend_bucket_name" {
  description = "Backend bucket name"
  type        = string
}

variable "backend_bucket_location" {
  description = "Backend bucket location"
  type        = string
  default = "EU"
}