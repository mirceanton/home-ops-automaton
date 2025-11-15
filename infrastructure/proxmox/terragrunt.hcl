include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform { source = "." }

inputs = {
  talos_version = "v1.11.3"
  proxmox_node_name = "pve01"
  op_vault_name = "Automation"
}