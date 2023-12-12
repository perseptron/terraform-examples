variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "VPC_custom"
}

variable "auto_subnet" {
  description = "Create subnets automatiacally"
  type        = bool
  default     = false
}

variable "mtu" {
  description = "Maximum Transmission Unit in bytes"
  type        = number
  default     = 1460
}

variable "mode" {
  description = "The network-wide routing mode to use."
  type        = string
  default     = "GLOBAL"
}

variable "vpc_subnet_name" {
  description = "VPC subnet name"
  type        = string
  default     = "custom-subnet"
}

variable "vpc_subnet_CIDR" {
  description = "VPC subnet CIDR"
  type        = string
  default     = "10.0.0.0/8"
}

variable "router_name" {
  description = "Google cloud router name"
  type        = string
  default     = "router4nat"
}

variable "firewall_name" {
  description = "Firewall name"
  type        = string
  default     = "icmp-ssh-http-https"
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(any)
  default     = ["80", "443", "22"]
}

variable "allowed_source" {
  description = "List of allowed source IPs"
  type        = list(any)
  default     = ["0.0.0.0/0"]
}