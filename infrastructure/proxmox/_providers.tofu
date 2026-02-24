terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.97.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.10.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
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
