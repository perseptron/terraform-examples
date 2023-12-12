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

//variable "zone" {
//  type        = string
//  description = "The availability zone where the instance will be deployed"
//  default     = "europe-central2-a"
//}

variable "service_account_id" {
  type        = string
  description = "Service account id we would use in our instance template config"
  default     = "a-abcd123ef"
}

variable "vpc_network_name" {
  description = "VPC network name"
  type        = string
  default     = "epam-task01-net"
}

variable "vpc_subnet_name" {
  description = "VPC subnet name"
  type        = string
  default     = "epam-task01-sub"
}

variable "vpc_subnet_CIDR" {
  description = "VPC subnet CIDR"
  type        = string
  default     = "172.16.0.0/16"
}

variable "backend_bucket_name" {
  description = "Backend bucket name"
  type        = string
  default     = "tfstate-perseptron"
}