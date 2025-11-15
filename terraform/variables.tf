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

variable "op_service_account_token" {
    description = "1Password service account token for API access."
    type        = string
    sensitive   = true
}
variable "op_vault_name" {
    description = "Name of the 1Password vault to store credentials in."
    type        = string
}