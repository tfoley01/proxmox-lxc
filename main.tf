locals {
  students = {
    "alice" = { id = 1101, ip = "192.168.10.101/24" }
    "bob"   = { id = 1102, ip = "192.168.10.102/24" }
    # ...
  }
}

resource "proxmox_virtual_environment_container" "labs" {
  for_each = local.students

  node_name = var.target_node
  vm_id     = each.value.id

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

  # Initialization (Cloud-Init style for LXC)
  initialization {

    hostname = "lab-${each.key}"

    user_account {
      password = var.student_password  # Or disable password
    }

    ip_config {
      ipv4 {
        address = "${each.value.ip}"
        gateway = var.gateway
      }
    }

    dns {
      servers = ["8.8.8.8", "1.1.1.1"]
    }
  }

  # Other useful settings
  unprivileged = true
  started      = true
  on_boot      = true

  tags = ["terraform", "lxc", "debian"]

}
