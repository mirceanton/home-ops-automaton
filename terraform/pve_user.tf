resource "random_password" "capmox_user_password" {
  length           = 32
  special          = true
  override_special = "_%@"
}

resource "proxmox_virtual_environment_user" "capmox" {
  user_id  = "capmox@pve"
  password = random_password.capmox_user_password.result
  enabled  = true
  comment  = "Managed by Terraform - Cluster API automation user"

  acl {
    path      = "/"
    propagate = true
    role_id   = "PVEVMAdmin"
  }
}

resource "proxmox_virtual_environment_user_token" "capmox_capi" {
  user_id               = proxmox_virtual_environment_user.capmox.user_id
  token_name            = "capi"
  comment               = "Managed by Terraform - Cluster API automation token"
  privileges_separation = true
}


output "capmox_capi_token_id" {
  description = "Identifier for the generated Proxmox API token."
  value       = proxmox_virtual_environment_user_token.capmox_capi.id
}

output "capmox_capi_token_value" {
  description = "API token secret; capture and rotate via your secret manager after apply."
  value       = proxmox_virtual_environment_user_token.capmox_capi.value
  sensitive   = true
}


resource "onepassword_item" "capmox_credentials" {
  title    = "CapMox Credentials"
  vault    = data.onepassword_vault.vault.uuid
  category = "login"

  section {
    label = "Credentials"

    field {
      label = "username"
      type  = "STRING"
      value = proxmox_virtual_environment_user.capmox.user_id
    }

    field {
      label = "password"
      type  = "CONCEALED"
      value = random_password.capmox_user_password.result
    }
  }

  section {
    label = "Automation"

    field {
      label = "api token"
      type  = "CONCEALED"
      value = proxmox_virtual_environment_user_token.capmox_capi.value
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