locals {
  students = {
    "luke" = { id = 1101, ip = "192.168.10.101/24" }
    "jordan"   = { id = 1102, ip = "192.168.10.102/24" }
    "benjamin"   = { id = 1102, ip = "192.168.10.102/24" }
    "jamie"   = { id = 1102, ip = "192.168.10.102/24" }
    "carter"   = { id = 1102, ip = "192.168.10.102/24" }
    "calvin"   = { id = 1102, ip = "192.168.10.102/24" }
    "ethan"   = { id = 1102, ip = "192.168.10.102/24" }
    "caleb"   = { id = 1102, ip = "192.168.10.102/24" }
    "mclane"   = { id = 1102, ip = "192.168.10.102/24" }
    # ...
  }
}

resource "proxmox_virtual_environment_container" "labs" {
  for_each = local.students
  node_name = var.target_node
  description = "Managed by Terraform via Semaphore"

 clone {
    vm_id = 104
    full = true
  }
timeout_clone = 3600   # 1 hour in seconds (default is 1800)
timeout_create = 3600
  memory {
    dedicated = var.memory
  }

 # Other useful settings
  unprivileged = true
  started      = false

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
