terraform {
  required_providers {
    esxi = {
      source  = "josenk/esxi"
      version = ">=1.10.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.4.0"
    }
  }
}