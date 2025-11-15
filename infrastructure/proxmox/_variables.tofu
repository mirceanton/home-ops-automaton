# =================================================================================================
# 1Password Variables
# =================================================================================================
variable "op_vault_name" {
  description = "Name of the 1Password vault to store credentials in."
  type        = string
}


# =================================================================================================
# Talos Template Variables
# =================================================================================================
variable "talos_version" {
  description = "Version of Talos Linux to deploy (e.g. v1.2.3)."
  type        = string
}

variable "proxmox_node_name" {
  description = "Name of the Proxmox node that will host the Talos template."
  type        = string
}
variable "proxmox_iso_datastore" {
  description = "Datastore where the Talos ISO will be downloaded."
  type        = string
  default     = "ceph-fs"
}

variable "proxmox_template_datastore" {
  description = "Datastore where the Talos VM template will be stored."
  type        = string
  default     = "ceph-rbd"
}
variable "proxmox_template_network_bridge" {
  description = "Network bridge to attach to the Talos VM template."
  type        = string
  default     = "vmbr0"
}