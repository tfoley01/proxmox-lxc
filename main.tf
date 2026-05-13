resource "proxmox_virtual_environment_container" "lxc" {
  node_name = var.target_node

  vm_id = var.vm_id

  name        = var.hostname
  description = "Managed by Terraform via Semaphore"

  ostemplate = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = "local-lvm"
    size         = var.disk_size
  }

  network_interface {
    name    = "eth0"
    bridge  = "vmbr0"
    enabled = true
  }

  ip_config {
    ipv4 {
      address = var.ip_address
      gateway = var.gateway
    }
  }

  tags = ["terraform", "lxc"]
}
