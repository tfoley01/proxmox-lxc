resource "proxmox_virtual_environment_container" "lxc" {
  node_name = var.target_node
  vm_id     = var.vm_id
  description = "Managed by Terraform via Semaphore"

  # ==================== Operating System ====================
  operating_system {
    template_file_id = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    type             = "debian"
  }

  # ==================== CPU & Memory ====================
  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  # ==================== Root Disk ====================
  disk {
    datastore_id = "local-lvm"
    size         = var.disk_size
  }

  # ==================== Network ====================
  network_interface {
    name    = "eth0"
    bridge  = "vmbr0"
    enabled = true
  }

  unprivileged = true
  started      = true

  tags = ["terraform", "lxc", "debian"]
}
