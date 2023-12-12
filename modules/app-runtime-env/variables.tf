variable "template_name" {
  description = "Template name"
  type        = string
  default     = "webserv"
}

variable "machine_type" {
  description = "Machine type"
  type        = string
  default     = "e2-medium"
}

variable "vpc_network_name" {
  description = "VPC network name"
  type        = string
}

variable "vpc_subnet_name" {
  description = "VPC subnet name"
  type        = string
}

variable "template_sa" {
  description = "Template service account"
  type        = string
}

variable "zone" {
  type        = string
  description = "The availability zone where the instance will be deployed"
  default     = "europe-central2-a"
}

variable "MIG_name" {
  type        = string
  description = "Managed instance group name"
  default     = "webserver-group"
}

variable "autoscaler_name" {
  type        = string
  description = "Managed instance group name"
  default     = "my-autoscaler"
}