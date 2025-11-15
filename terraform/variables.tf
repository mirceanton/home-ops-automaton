# =================================================================================================
# Proxmox Variables
# =================================================================================================
variable "proxmox_api_url" {
  description = "Base URL of the Proxmox API, e.g. https://pve.example.com:8006/"
  type        = string
}

variable "proxmox_user" {
  description = "Username (user@realm) used to authenticate against the Proxmox API."
  type        = string
}

variable "proxmox_password" {
  description = "Password for the Proxmox API user."
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Whether to skip TLS verification when connecting to Proxmox."
  type        = bool
  default     = false
}

# =================================================================================================
# 1Password Variables
# =================================================================================================
variable "op_service_account_token" {
  description = "1Password service account token for API access."
  type        = string
  sensitive   = true
}
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
  default     = "local-lvm"
}

variable "proxmox_template_datastore" {
  description = "Datastore where the Talos VM template will be stored."
  type        = string
  default     = "local-lvm"
}
variable "proxmox_template_network_bridge" {
  description = "Network bridge to attach to the Talos VM template."
  type        = string
  default     = "vmbr0"
}