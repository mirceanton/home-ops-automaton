terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.91.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.10.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = var.proxmox_insecure
}
provider "onepassword" {
  service_account_token = var.op_service_account_token
}
