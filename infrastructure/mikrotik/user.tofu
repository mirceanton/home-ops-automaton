# ================================================================================================
# MikroTik User
# ================================================================================================
resource "random_password" "external_dns_password" { length = 32 }
resource "routeros_system_user" "external-dns" {
  name     = "external-dns"
  group    = "full" #!FIXME: Adjust permissions as needed
  comment = "Managed by Terraform"
  password = random_password.external_dns_password.result
}

# =================================================================================================
# 1Password Integration
# =================================================================================================
data "onepassword_vault" "vault" { name = var.op_vault_name }
resource "onepassword_item" "mikrotik_external_dns_credentials" {
  title    = "Mikrotik ExternalDNS Credentials"
  vault    = data.onepassword_vault.vault.uuid
  category = "login"

  section {
    label = "Credentials"

    field {
      label = "username"
      type  = "STRING"
      value = routeros_system_user.external-dns.name
    }

    field {
      label = "password"
      type  = "CONCEALED"
      value = random_password.external_dns_password.result
    }
  }

  section {
    label = "Notes"

    field {
      label = "notes"
      type  = "STRING"
      value = "Mikrotik user credentials for external-dns | Managed by Terraform"
    }
  }
}