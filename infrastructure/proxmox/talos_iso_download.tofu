# =================================================================================================
# Generate Talos Image with extensions
# =================================================================================================
# Fetch the Talos extension versions for the specified Talos version
data "talos_image_factory_extensions_versions" "this" {
  talos_version = var.talos_version
  filters       = { names = ["qemu-guest-agent"] }
}

# Create a Talos image factory schematic with the specified extensions
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.this.extensions_info.*.name
        }
      }
    }
  )
}

# Fetch the Talos image URLs based on the schematic
data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = "nocloud" #! for cloud-init compatibility
  architecture  = "amd64"
}

# Outputs
output "schematic_id" {
  description = "Talos image factory schematic ID"
  value       = talos_image_factory_schematic.this.id
}
output "installer_url" {
  description = "Talos installer URL"
  value       = data.talos_image_factory_urls.this.urls.installer
}
output "iso_url" {
  description = "Talos ISO URL"
  value       = data.talos_image_factory_urls.this.urls.iso
}
output "disk_image_url" {
  description = "Talos disk image URL"
  value       = data.talos_image_factory_urls.this.urls.disk_image
}


# =================================================================================================
# Download Talos disk image to Proxmox
# =================================================================================================
resource "proxmox_virtual_environment_download_file" "talos_disk_image" {
  content_type = "iso"
  datastore_id = var.proxmox_iso_datastore
  node_name    = var.proxmox_node_name
  url          = data.talos_image_factory_urls.this.urls.disk_image
  file_name    = "talos-${var.talos_version}-nocloud-amd64.img"

  decompression_algorithm = "zst"
}

# Outputs
output "talos_disk_image_id" {
  description = "Proxmox file ID for the Talos disk image"
  value       = proxmox_virtual_environment_download_file.talos_disk_image.id
}
