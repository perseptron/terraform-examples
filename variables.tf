variable "esxi_hostname" {
  description = "ESXI server host name."
  default     = "172.16.2.11"
}
variable "esxi_hostport" {
  description = "ESXI server port."
  default     = "22"
}
variable "esxi_hostssl" {
  description = "ESXI server SSH port."
  default     = "443"
}
variable "esxi_username" {
  description = "ESXI server user name."
  default     = "root"
}
variable "esxi_password" { # Unspecified will prompt
  description = "ESXI server password."
  sensitive   = true
}
# # Expire at first login, so terraform ssh provision couldn't execute
# variable "default_password" {
#   type      = string
#   sensitive = true
# }
variable "guest" {
  type        = string
  description = "Name of VM"
  default     = "vm01"
}

variable "default-ssh-user" {
  type    = string
  default = "ubuntu"
}

variable "numvcpus" {
  description = "Number of CPU"
  default     = 1
}

variable "memsize" {
  description = "Memory size"
  default     = 1024
}

variable "boot_disk_size" {
  default = 10
}

variable "disk_store" {
  default = "big-mirror"
}

variable "virtual_network" {
  default = "VM Network"
}

variable "ovf_file" {
  #  A local file downloaded from https://cloud-images.ubuntu.com
  default = "C:\\Users\\mandrake\\Downloads\\ubuntu-22.04-server-cloudimg-amd64.ova"

  #  Or specify a remote (url) file
  #default = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.ova"
}

variable "script_file" {
  default = "script.sh"
}

provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_hostssl  = var.esxi_hostssl
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}
