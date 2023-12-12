variable "project" {
  description = "Your project name"
  type        = string
  default     = "project1-407717"
}

variable "sa_id" {
  description = "Service account ID"
  type        = string
}

variable "sa_name" {
  description = "Service account name"
  type        = string
  default = "template_sa"
}
