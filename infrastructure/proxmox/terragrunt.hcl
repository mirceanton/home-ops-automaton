include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform { source = "." }

inputs = {
  #!FIXME: should be some sort of loadbalancer, not just the ip of pve01
  proxmox_endpoint  = "https://pve01.mgmt.h.mirceanton.com:8006"
  proxmox_username  = get_env("PROXMOX_USERNAME")
  proxmox_password  = get_env("PROXMOX_PASSWORD")
  proxmox_insecure  = true

  op_service_account_token = get_env("OP_SERVICE_ACCOUNT_TOKEN")

  talos_version     = "v1.11.3"
  proxmox_node_name = "pve01"
  op_vault_name     = "Automation"
}