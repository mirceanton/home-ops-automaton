# ================================================================================================
# PVE User
# ================================================================================================
resource "random_password" "capmox_user_password" { length = 32 }
resource "proxmox_virtual_environment_user" "capmox" {
  user_id  = "capmox@pve"
  password = random_password.capmox_user_password.result
  enabled  = true
  comment  = "Managed by Terraform - Cluster API automation user"

  acl {
    path      = "/"
    propagate = true
    role_id   = "Administrator"
  }
}


# ===============================================================================================
# PVE User Token
# ===============================================================================================
resource "proxmox_virtual_environment_user_token" "capmox_capi" {
  user_id               = proxmox_virtual_environment_user.capmox.user_id
  token_name            = "capi"
  comment               = "Managed by Terraform - Cluster API automation token"
  privileges_separation = false
}


# =================================================================================================
# 1Password Integration
# =================================================================================================
data "onepassword_vault" "vault" { name = var.op_vault_name }
resource "onepassword_item" "capmox_credentials" {
  title = "CapMox Credentials"
  vault = data.onepassword_vault.vault.uuid

  category = "login"
  username = proxmox_virtual_environment_user.capmox.user_id
  password = random_password.capmox_user_password.result

  section {
    label = "Automation"

    field {
      label = "proxmox url"
      type  = "STRING"
      value = var.proxmox_endpoint
    }

    field {
      label = "token name"
      type  = "STRING"
      value = proxmox_virtual_environment_user_token.capmox_capi.token_name
    }

    field {
      label = "api token full"
      type  = "CONCEALED"
      value = proxmox_virtual_environment_user_token.capmox_capi.value
    }

    field {
      label = "api token secret"
      type  = "CONCEALED"
      value = split("=", proxmox_virtual_environment_user_token.capmox_capi.value)[1]
    }
  }

  section {
    label = "Notes"

    field {
      label = "notes"
      type  = "STRING"
      value = "Proxmox user credentials for capmox@pve managed by Terraform."
    }
  }
}