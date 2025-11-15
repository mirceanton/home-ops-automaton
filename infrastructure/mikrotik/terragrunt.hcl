include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform { source = "." }

inputs = {
  op_vault_name      = "Automation"
}