terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.97.0"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "routeros" {}
provider "onepassword" {}