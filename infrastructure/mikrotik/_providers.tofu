terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.98.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.0"
    }
  }
}

provider "routeros" {}
provider "onepassword" {}