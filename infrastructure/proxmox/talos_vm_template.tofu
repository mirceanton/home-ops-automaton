resource "proxmox_virtual_environment_vm" "talos_template" {
  node_name = var.proxmox_node_name

  vm_id       = 9000
  name        = "talos-${var.talos_version}-template"
  description = "Managed by Terraform - Talos Linux VM template"
  tags        = ["talos-${var.talos_version}", "template", "capi"]
  template    = true
  machine     = "q35"

  operating_system { type = "l26" }
  agent {
    enabled = true
    trim    = true
    type    = "virtio"
  }

  cpu {
    cores        = "2"
    type         = "x86-64-v2"
    architecture = "x86_64"
    sockets      = 1
    numa         = true
  }

  memory {
    dedicated = "2048" # MB
  }

  # Boot Disk
  scsi_hardware = "virtio-scsi-single"
  disk {
    datastore_id = var.proxmox_template_datastore
    size         = "4" # GB
    interface    = "scsi0"
    file_format  = "raw"
  }

  # Talos ISO
  cdrom {
    file_id   = proxmox_virtual_environment_download_file.talos_iso.id
    interface = "ide0"
  }

  network_device {
    bridge = var.proxmox_template_network_bridge
  }

  vga { type = "serial0" }
  serial_device {}

  lifecycle {
    ignore_changes = [
      ipv4_addresses,
      ipv6_addresses,
      network_interface_names,
    ]
  }
}
