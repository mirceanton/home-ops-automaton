terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.92.1"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "routeros" {}
provider "onepassword" {}