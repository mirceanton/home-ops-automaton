terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.0"
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

provider "routeros" {}
provider "onepassword" {}