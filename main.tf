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

  description = "Managed by Terraform via Semaphore"
  
 clone {
    vm_id = 104
  }

  memory {
    dedicated = var.memory
  }

 # Other useful settings
  unprivileged = true
  started      = true

  tags = ["terraform", "lxc", "debian"]

  # Initialization (Cloud-Init style for LXC)
  initialization {

    hostname = "lab-${each.key}"

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
}
